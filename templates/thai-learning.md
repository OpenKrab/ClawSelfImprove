## [LRN-YYYYMMDD-XXX] category (thai)

**Logged**: ISO-8601 timestamp
**Language**: th
**Priority**: low | medium | high | critical
**Status**: pending
**Area**: frontend | backend | infra | tests | docs | config

### สรุป (Summary)
บรรทัดเดียวอธิบายสิ่งที่เรียนรู้

### รายละเอียด (Details)
บริบทเต็ม: เกิดอะไรขึ้น อะไรผิด อะไรถูกต้อง

### ข้อเสนอแนะ (Suggested Action)
การแก้ไขหรือปรับปรุงที่เฉพาะเจาะจง

### เมตาดาทา (Metadata)
- Source: conversation | error | user_feedback
- Related Files: path/to/file.ext
- Tags: tag1, tag2
- See Also: LRN-20260302-001 (if related to existing entry)
- Pattern-Key: simplify.dead_code | harden.input_validation (optional)
- Recurrence-Count: 1 (optional)
- First-Seen: 2026-03-02 (optional)
- Last-Seen: 2026-03-02 (optional)

---

## Thai Learning Categories

### correction (การแก้ไข)
User แก้ไขคำตอบของ AI:
- "ไม่ใช่แบบนั้น..."
- "จริงๆ แล้วควรเป็น..."
- "คุณผิดเกี่ยวกับ..."
- "ข้อมูลเก่า..."

### knowledge_gap (ช่องว่างความรู้)
AI ไม่รู้ข้อมูลที่ User บอก:
- User ให้ข้อมูลใหม่
- Document ที่อ้างอิงเก่า
-พฤติกรรม API ต่างจากที่เข้าใจ

### best_practice (แนวทางปฏิบัติที่ดี)
พบวิธีที่ดีกว่า:
- ปรับปรุง performance
- ลดความซับซ้อน
- เพิ่มความปลอดภัย
- ปรับปรุง user experience

### workflow_improvement (การปรับปรุง workflow)
พบวิธีทำงานที่ดีกว่า:
- ทำให้ process เร็วขึ้น
- ลองขั้นตอนที่ไม่จำเป็น
- ทำให้ทำซ้ำได้ง่ายขึ้น

## Thai Priority Guidelines

| Priority | เมื่อไหร่ควรใช้ |
|----------|----------------|
| `critical` | บล็อกฟังก์ชันหลัก, เสี่ยงต่อการสูญเสียข้อมูล, ปัญหาความปลอดภัย |
| `high` | ผลกระทบสูง, กระทบ workflow ทั่วไป, ปัญหาที่เกิดซ้ำ |
| `medium` | ผลกระทบปานกลาง, มีวิธีแก้ชั่วคราว |
| `low` | ข้อผิดพลาดเล็กน้อย, edge case, สิ่งที่ดีถ้ามี |

## Thai Area Tags

| Area | ขอบเขต |
|------|---------|
| `frontend` | UI, components, client-side code |
| `backend` | API, services, server-side code |
| `infra` | CI/CD, deployment, Docker, cloud |
| `tests` | Test files, testing utilities, coverage |
| `docs` | Documentation, comments, READMEs |
| `config` | Configuration files, environment, settings |

## Example Thai Learning Entry

## [LRN-20260302-001] correction (thai)

**Logged**: 2026-03-02T14:30:00+07:00
**Language**: th
**Priority**: high
**Status**: pending
**Area**: backend

### สรุป
ใช้ async/await แทน .then() สำหรับ API calls เพื่อจัดการ error ได้ดีขึ้น

### รายละเอียด
User แก้ไขว่าควรใช้ async/await pattern แทนการใช้ .then() chain
เพราะว่า:
1. จัดการ error ได้ง่ายกว่าด้วย try/catch
2. อ่าน code ง่ายกว่า sequential flow
3. debugging ง่ายกว่า

ตัวอย่างที่ User แนะนำ:
```javascript
// แทนที่จะใช้ .then()
fetch('/api/data')
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error(error));

// ให้ใช้ async/await
async function fetchData() {
  try {
    const response = await fetch('/api/data');
    const data = await response.json();
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}
```

### ข้อเสนอแนะ
1. เปลี่ยนทุก API call ที่ใช้ .then() เป็น async/await
2. เพิ่ม error handling ที่เหมาะสม
3. อัพเดท documentation ให้แสดงตัวอย่าง async/await

### เมตาดาทา
- Source: user_feedback
- Related Files: src/api/*.js
- Tags: javascript, async, await, error-handling
- Pattern-Key: javascript.async_await_pattern
- Recurrence-Count: 1
- First-Seen: 2026-03-02
- Last-Seen: 2026-03-02

---
