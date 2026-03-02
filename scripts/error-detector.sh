#!/bin/bash
# ClawSelfImprove Error Detector Hook
# Enhanced version with Thai support, privacy filters, and ClawMemory integration
# Triggers on PostToolUse for Bash to detect command failures

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/../config.yaml"

# Load configuration if exists
if [ -f "$CONFIG_FILE" ]; then
    # Simple YAML parsing for boolean values
    PRIVACY_FILTER=$(grep "privacy_filter:" "$CONFIG_FILE" | cut -d: -f2 | tr -d ' ')
    THAI_SUPPORT=$(grep "thai_support:" "$CONFIG_FILE" | cut -d: -f2 | tr -d ' ')
else
    PRIVACY_FILTER="true"
    THAI_SUPPORT="true"
fi

# Check for Thai language preference
THAI_MODE=false
if [[ "$THAI_SUPPORT" == "true" ]] && [[ "$LANG" == *"th"* || "$LC_ALL" == *"th"* || -f ~/.openclaw/skills/claw-selfimprove/thai-mode ]]; then
    THAI_MODE=true
fi

# Get tool output
OUTPUT="${CLAUDE_TOOL_OUTPUT:-}"
TOOL_NAME="${CLAUDE_TOOL_NAME:-bash}"

# Privacy filter patterns
PRIVACY_PATTERNS=(
    "password"
    "secret"
    "token"
    "api_key"
    "credential"
    "private_key"
    "auth"
)

# Enhanced error patterns (including Thai errors)
ERROR_PATTERNS=(
    # English errors
    "error:"
    "Error:"
    "ERROR:"
    "failed"
    "FAILED"
    "command not found"
    "No such file"
    "Permission denied"
    "fatal:"
    "Exception"
    "Traceback"
    "npm ERR!"
    "ModuleNotFoundError"
    "SyntaxError"
    "TypeError"
    "exit code"
    "non-zero"
    "Access denied"
    "Connection refused"
    "Timeout"
    
    # Thai errors
    "ข้อผิดพลาด"
    "ไม่พบไฟล์"
    "ไม่มีสิทธิ์"
    "ล้มเหลว"
    "บรรทัดคำสั่งไม่พบ"
    "หมดเวลา"
    "ปฏิเสธการเชื่อมต่อ"
)

# Check for privacy concerns
contains_sensitive=false
if [ "$PRIVACY_FILTER" == "true" ]; then
    for pattern in "${PRIVACY_PATTERNS[@]}"; do
        if [[ "$OUTPUT" == *"$pattern"* ]]; then
            contains_sensitive=true
            break
        fi
    done
fi

# Skip if sensitive data detected
if [ "$contains_sensitive" = true ]; then
    cat << 'EOF'
<claw-selfimprove-privacy-alert>
Error output contains potentially sensitive information.
Manual review required before logging to learnings.
Consider redacting sensitive data before logging.
</claw-selfimprove-privacy-alert>
EOF
    exit 0
fi

# Check if output contains any error pattern
contains_error=false
for pattern in "${ERROR_PATTERNS[@]}"; do
    if [[ "$OUTPUT" == *"$pattern"* ]]; then
        contains_error=true
        break
    fi
done

# Only output reminder if error detected
if [ "$contains_error" = true ]; then
    if [ "$THAI_MODE" = true ]; then
        cat << 'EOF'
<claw-selfimprove-error-detected language="thai">
ตรวจพบข้อผิดพลาดจากคำสั่ง พิจารณาบันทึกลง .learnings/ERRORS.md ถ้า:
- ข้อผิดพลาดไม่คาดคิดหรือซับซ้อน
- ต้องการการสืบสวนเพื่อแก้ไข
- อาจเกิดซ้ำในสถานการณ์คล้ายกัน
- วิธีแก้สามารถช่วย session ถัดไปได้

ใช้รูปแบบ: [ERR-YYYYMMDD-XXX]
พิจารณาส่งเข้า ClawMemory ถ้าเป็นปัญหาที่เกิดซ้ำ
</claw-selfimprove-error-detected>
EOF
    else
        cat << 'EOF'
<claw-selfimprove-error-detected>
A command error was detected in $TOOL_NAME output. Consider logging this to .learnings/ERRORS.md if:
- The error was unexpected or non-obvious
- It required investigation to resolve
- It might recur in similar contexts
- The solution could benefit future sessions
- This is a recurring pattern

Use format: [ERR-YYYYMMDD-XXX]
Consider promotion to ClawMemory for recurring issues
</claw-selfimprove-error-detected>
EOF
    fi
fi
