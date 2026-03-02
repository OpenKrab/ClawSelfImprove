#!/bin/bash
# ClawSelfImprove Bootstrap Hook
# Runs when OpenClaw agent starts a new session
# Injects learning reminders and sets up environment

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
LEARNINGS_DIR="$SKILL_DIR/.learnings"

# Check for Thai language preference
THAI_MODE=false
if [[ "$LANG" == *"th"* ]] || [[ "$LC_ALL" == *"th"* ]] || [[ -f "$SKILL_DIR/thai-mode" ]]; then
    THAI_MODE=true
fi

# Create learnings directory if it doesn't exist
mkdir -p "$LEARNINGS_DIR"

# Initialize learning files if they don't exist
init_learning_file() {
    local file="$1"
    local template="$2"
    
    if [[ ! -f "$file" ]]; then
        if [[ -f "$template" ]]; then
            cp "$template" "$file"
        else
            touch "$file"
        fi
    fi
}

# Initialize standard learning files
init_learning_file "$LEARNINGS_DIR/LEARNINGS.md" "$SKILL_DIR/templates/learning-entry.md"
init_learning_file "$LEARNINGS_DIR/ERRORS.md" "$SKILL_DIR/templates/error-entry.md"
init_learning_file "$LEARNINGS_DIR/LEARNINGS-TH.md" "$SKILL_DIR/templates/thai-learning.md"

# Count existing learnings
LEARNING_COUNT=$(grep -c "^## \[LRN-" "$LEARNINGS_DIR/LEARNINGS.md" 2>/dev/null || echo "0")
ERROR_COUNT=$(grep -c "^## \[ERR-" "$LEARNINGS_DIR/ERRORS.md" 2>/dev/null || echo "0")

# Output bootstrap message
if [ "$THAI_MODE" = true ]; then
    cat << EOF
<claw-selfimprove-bootstrap language="thai">
🦞 **ClawSelfImprove พร้อมใช้งาน**

📊 **สถานะการเรียนรู้:**
- บทเรียนที่บันทึก: $LEARNING_COUNT รายการ
- ข้อผิดพลาดที่บันทึก: $ERROR_COUNT รายการ

🎯 **พร้อมทำงาน:**
- ตรวจจับข้อผิดพลาดอัตโนมัติ ✅
- รองรับภาษาไทย ✅
- ป้องกันข้อมูลสำคัญ ✅
- ส่งเข้า ClawMemory เมื่อมีค่าสูง ✅

💡 **คำแนะนำ:** ทุกครั้งที่เจอข้อผิดพลาดหรือ User แก้ไข ให้บันทึกเป็น learning
</claw-selfimprove-bootstrap>
EOF
else
    cat << EOF
<claw-selfimprove-bootstrap>
🦞 **ClawSelfImprove Ready**

📊 **Learning Status:**
- Learnings captured: $LEARNING_COUNT entries
- Errors logged: $ERROR_COUNT entries

🎯 **Capabilities Active:**
- Automatic error detection ✅
- Thai language support ✅
- Privacy protection ✅
- ClawMemory integration ✅

💡 **Reminder:** Log errors and corrections to build your knowledge base
</claw-selfimprove-bootstrap>
EOF
fi

# Check for pending high-priority items and show reminder
if [ "$LEARNING_COUNT" -gt 0 ]; then
    HIGH_PRIORITY=$(grep -A1 "Priority.*high" "$LEARNINGS_DIR/LEARNINGS.md" | grep "^## \[" | wc -l)
    if [ "$HIGH_PRIORITY" -gt 0 ]; then
        if [ "$THAI_MODE" = true ]; then
            echo "<claw-selfimprove-alert>⚠️ มี $HIGH_PRIORITY บทเรียนที่สำคัญรอการตรวจสอบ</claw-selfimprove-alert>"
        else
            echo "<claw-selfimprove-alert>⚠️ $HIGH_PRIORITY high-priority learnings pending review</claw-selfimprove-alert>"
        fi
    fi
fi
