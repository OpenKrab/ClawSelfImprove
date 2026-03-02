#!/bin/bash
# ClawSelfImprove Activator Hook
# Enhanced version with Thai support and ClawMemory integration
# Triggers on UserPromptSubmit to remind agent about learning capture

set -e

# Check for Thai language preference
THAI_MODE=false
if [[ "$LANG" == *"th"* ]] || [[ "$LC_ALL" == *"th"* ]] || [[ -f ~/.openclaw/skills/claw-selfimprove/thai-mode ]]; then
    THAI_MODE=true
fi

# Output reminder based on language mode
if [ "$THAI_MODE" = true ]; then
    cat << 'EOF'
<claw-selfimprove-reminder language="thai">
หลังจากทำงานนี้เสร็จ ให้ประเมินว่ามีความรู้ที่ควรเก็บไว้หรือไม่:
- พบวิธีแก้ปัญหาที่ไม่ชัดเจน?
- เจอวิธีแก้ขัดข้องที่ไม่คาดคิด?
- เรียนรู้ pattern พิเศษของโปรเจกต์?
- แก้ bug ที่ต้องการการ debug ซับซ้อน?

ถ้าใช่: บันทึกลง .learnings/ ด้วยรูปแบบ ClawSelfImprove
ถ้ามีค่าสูง (ใช้ซ้ำได้, ใช้ได้กับหลายที่): พิจารณาส่งเข้า ClawMemory
</claw-selfimprove-reminder>
EOF
else
    cat << 'EOF'
<claw-selfimprove-reminder>
After completing this task, evaluate if extractable knowledge emerged:
- Non-obvious solution discovered through investigation?
- Workaround for unexpected behavior?
- Project-specific pattern learned?
- Error required debugging to resolve?
- Thai language correction received?

If yes: Log to .learnings/ using ClawSelfImprove format
If high-value (recurring, broadly applicable): Consider promotion to ClawMemory
</claw-selfimprove-reminder>
EOF
fi
