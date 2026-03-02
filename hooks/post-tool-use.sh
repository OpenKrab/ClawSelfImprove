#!/bin/bash
# ClawSelfImprove Post-Tool-Use Hook
# Enhanced version with Thai support and smart error detection
# Runs after tool execution to capture learnings

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG_FILE="$SKILL_DIR/config.yaml"

# Load configuration
load_config() {
    if [[ -f "$CONFIG_FILE" ]]; then
        PRIVACY_FILTER=$(grep "privacy_filter:" "$CONFIG_FILE" | cut -d: -f2 | tr -d ' ' || echo "true")
        THAI_SUPPORT=$(grep "thai_support:" "$CONFIG_FILE" | cut -d: -f2 | tr -d ' ' || echo "true")
        AUTO_PROMOTE=$(grep "auto_promote:" "$CONFIG_FILE" | cut -d: -f2 | tr -d ' ' || echo "false")
    else
        PRIVACY_FILTER="true"
        THAI_SUPPORT="true"
        AUTO_PROMOTE="false"
    fi
}

# Detect language
detect_language() {
    if [[ "$THAI_SUPPORT" == "true" ]] && [[ "$LANG" == *"th"* || "$LC_ALL" == *"th"* || -f "$SKILL_DIR/thai-mode" ]]; then
        echo "thai"
    else
        echo "english"
    fi
}

# Check for sensitive data
check_privacy() {
    local text="$1"
    if [[ "$PRIVACY_FILTER" != "true" ]]; then
        return 0
    fi
    
    local sensitive_patterns=(
        "password"
        "secret"
        "token"
        "api_key"
        "credential"
        "private_key"
        "auth"
        "รหัสผ่าน"
        "คีย์"
        "โทเคน"
    )
    
    for pattern in "${sensitive_patterns[@]}"; do
        if [[ "$text" == *"$pattern"* ]]; then
            return 1
        fi
    done
    return 0
}

# Analyze tool output for learning opportunities
analyze_output() {
    local tool_name="$1"
    local output="$2"
    local exit_code="${3:-0}"
    local language=$(detect_language)
    
    # Skip if privacy concerns
    if ! check_privacy "$output"; then
        echo "<claw-selfimprove-privacy>Output contains sensitive data - manual review required</claw-selfimprove-privacy>"
        return
    fi
    
    # Error detection
    if [[ "$exit_code" != "0" ]]; then
        handle_error "$tool_name" "$output" "$exit_code" "$language"
        return
    fi
    
    # Success but with warnings or interesting patterns
    detect_learning_opportunities "$tool_name" "$output" "$language"
}

# Handle tool errors
handle_error() {
    local tool_name="$1"
    local output="$2"
    local exit_code="$3"
    local language="$4"
    
    if [[ "$language" == "thai" ]]; then
        cat << EOF
<claw-selfimprove-error language="thai">
❌ **คำสั่งล้มเหลว**: $tool_name (exit code: $exit_code)

พิจารณาบันทึกลง .learnings/ERRORS.md ถ้า:
- ข้อผิดพลาดไม่คาดคิดหรือซับซ้อน
- ต้องการการสืบสวนเพื่อแก้ไข
- อาจเกิดซ้ำในสถานการณ์คล้ายกัน

ใช้รูปแบบ: [ERR-$(date +%Y%m%d)-XXX]
</claw-selfimprove-error>
EOF
    else
        cat << EOF
<claw-selfimprove-error>
❌ **Command Failed**: $tool_name (exit code: $exit_code)

Consider logging to .learnings/ERRORS.md if:
- The error was unexpected or non-obvious
- It required investigation to resolve
- It might recur in similar contexts

Use format: [ERR-$(date +%Y%m%d)-XXX]
</claw-selfimprove-error>
EOF
    fi
}

# Detect learning opportunities in successful outputs
detect_learning_opportunities() {
    local tool_name="$1"
    local output="$2"
    local language="$3"
    
    # Patterns that suggest learning opportunities
    local learning_patterns=(
        "warning:"
        "deprecated"
        "consider using"
        "better to use"
        "recommended"
        "แนะนำ"
        "ควรใช้"
        "เตือน"
    )
    
    local found_learning=false
    for pattern in "${learning_patterns[@]}"; do
        if [[ "$output" == *"$pattern"* ]]; then
            found_learning=true
            break
        fi
    done
    
    if [[ "$found_learning" == "true" ]]; then
        if [[ "$language" == "thai" ]]; then
            cat << EOF
<claw-selfimprove-opportunity language="thai">
💡 **พบโอกาสเรียนรู้** จาก $tool_name

Output มีคำแนะนำหรือคำเตือน
พิจารณาบันทึกเป็น best practice ถ้า:
- เป็นการแนะนำที่ดีกว่าวิธีปัจจุบัน
- เป็น pattern ที่ควรนำไปใช้ซ้ำ
- เป็นการปรับปรุง performance หรือ security

บันทึกลง .learnings/LEARNINGS.md
</claw-selfimprove-opportunity>
EOF
        else
            cat << EOF
<claw-selfimprove-opportunity>
💡 **Learning Opportunity** from $tool_name

Output contains recommendations or warnings
Consider logging as best practice if:
- Suggests better approach than current method
- Represents a reusable pattern
- Improves performance or security

Log to .learnings/LEARNINGS.md
</claw-selfimprove-opportunity>
EOF
        fi
    fi
}

# Main execution
main() {
    load_config
    
    # Get tool information from environment
    local tool_name="${CLAUDE_TOOL_NAME:-unknown}"
    local output="${CLAUDE_TOOL_OUTPUT:-}"
    local exit_code="${CLAUDE_TOOL_EXIT_CODE:-0}"
    
    # Skip for certain tools that are too noisy
    case "$tool_name" in
        "read_file"|"list_dir"|"grep_search")
            # These are usually safe and don't need learning capture
            exit 0
            ;;
    esac
    
    # Analyze the output
    analyze_output "$tool_name" "$output" "$exit_code"
}

# Run main function
main "$@"
