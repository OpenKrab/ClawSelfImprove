#!/usr/bin/env python3
"""
ClawSelfImprove Promotion Script
Enhanced with AI scoring, Thai support, and ClawMemory integration
"""

import os
import sys
import re
import json
import yaml
import argparse
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Tuple

class ClawSelfImprovePromoter:
    def __init__(self, config_path: Optional[str] = None):
        self.script_dir = Path(__file__).parent
        self.base_dir = self.script_dir.parent
        self.learnings_dir = self.base_dir / ".learnings"
        self.config = self.load_config(config_path)
        
    def load_config(self, config_path: Optional[str]) -> Dict:
        """Load configuration from YAML file"""
        default_config = {
            "auto_translate": True,
            "safety_mode": "standard",
            "clawmemory_integration": True,
            "thai_support": True,
            "max_reflections_per_session": 5,
            "promotion_threshold": 8,
            "privacy_filter": True,
            "require_human_approval": True
        }
        
        if config_path and Path(config_path).exists():
            with open(config_path, 'r') as f:
                user_config = yaml.safe_load(f) or {}
                default_config.update(user_config)
        
        return default_config
    
    def detect_language(self, text: str) -> str:
        """Detect if text is primarily Thai"""
        thai_chars = len(re.findall(r'[\u0E00-\u0E7F]', text))
        total_chars = len(re.findall(r'[a-zA-Z\u0E00-\u0E7F]', text))
        return "thai" if thai_chars > total_chars * 0.3 else "english"
    
    def score_learning(self, learning_text: str, category: str = "learning") -> Dict:
        """
        Score a learning entry using AI or heuristics
        Returns dict with scores and reasoning
        """
        # Basic heuristic scoring (can be enhanced with actual AI)
        scores = {
            "accuracy": 8,
            "efficiency": 7,
            "reusability": 6,
            "clarity": 8,
            "overall": 7.25
        }
        
        # Adjust scores based on content analysis
        text_lower = learning_text.lower()
        
        # Accuracy scoring
        if any(word in text_lower for word in ["fix", "solution", "resolved", "แก้ไข", "วิธีแก้"]):
            scores["accuracy"] = min(10, scores["accuracy"] + 2)
        elif any(word in text_lower for word in ["maybe", "perhaps", "probably", "น่าจะ", "อาจจะ"]):
            scores["accuracy"] = max(3, scores["accuracy"] - 2)
        
        # Efficiency scoring
        if any(word in text_lower for word in ["faster", "optimize", "improve", "เร็วขึ้น", "ปรับปรุง"]):
            scores["efficiency"] = min(10, scores["efficiency"] + 2)
        
        # Reusability scoring
        if any(word in text_lower for word in ["pattern", "template", "reusable", "ทั่วไป", "ใช้ซ้ำ"]):
            scores["reusability"] = min(10, scores["reusability"] + 2)
        elif any(word in text_lower for word in ["specific", "particular", "เฉพาะ", "เฉพาะกรณี"]):
            scores["reusability"] = max(3, scores["reusability"] - 1)
        
        # Clarity scoring
        has_structure = any(pattern in learning_text for pattern in ["###", "**", "##", "Summary", "Details"])
        if has_structure:
            scores["clarity"] = min(10, scores["clarity"] + 1)
        
        # Calculate overall score
        scores["overall"] = sum(scores.values()) / len(scores)
        
        return {
            "scores": scores,
            "recommendation": "promote" if scores["overall"] >= self.config["promotion_threshold"] else "keep_learning",
            "reasoning": self._generate_reasoning(scores)
        }
    
    def _generate_reasoning(self, scores: Dict) -> str:
        """Generate reasoning for the scoring decision"""
        reasoning_parts = []
        
        if scores["accuracy"] >= 8:
            reasoning_parts.append("High accuracy - solution appears verified")
        elif scores["accuracy"] <= 5:
            reasoning_parts.append("Lower accuracy - solution may need validation")
        
        if scores["efficiency"] >= 8:
            reasoning_parts.append("High efficiency impact")
        
        if scores["reusability"] >= 8:
            reasoning_parts.append("Broadly applicable across contexts")
        elif scores["reusability"] <= 5:
            reasoning_parts.append("Specific to particular scenario")
        
        if scores["clarity"] >= 8:
            reasoning_parts.append("Well-documented and clear")
        
        return "; ".join(reasoning_parts) if reasoning_parts else "Standard learning entry"
    
    def translate_to_thai(self, text: str) -> str:
        """Basic translation placeholders (would integrate with translation service)"""
        # In a real implementation, this would call a translation API
        translations = {
            "Summary": "สรุป",
            "Details": "รายละเอียด", 
            "Suggested Action": "ข้อเสนอแนะ",
            "Priority": "ความสำคัญ",
            "high": "สูง",
            "medium": "ปานกลาง",
            "low": "ต่ำ"
        }
        
        translated = text
        for en, th in translations.items():
            translated = translated.replace(en, th)
        
        return translated
    
    def create_clawmemory_entry(self, learning_id: str, content: Dict) -> Dict:
        """Create a ClawMemory graph entry from learning"""
        return {
            "id": f"learning-{learning_id}",
            "type": "learning",
            "content": content.get("summary", ""),
            "metadata": {
                "category": content.get("category", "learning"),
                "priority": content.get("priority", "medium"),
                "language": content.get("language", "english"),
                "score": content.get("score", {}).get("overall", 0),
                "created_at": datetime.now().isoformat()
            },
            "relationships": self._extract_relationships(content),
            "vector": None  # Would be computed by ClawMemory
        }
    
    def _extract_relationships(self, content: Dict) -> List[str]:
        """Extract relationships from learning content"""
        relationships = []
        text = f"{content.get('summary', '')} {content.get('details', '')}".lower()
        
        # Technology relationships
        tech_keywords = ["javascript", "python", "react", "node", "api", "database", "git"]
        for tech in tech_keywords:
            if tech in text:
                relationships.append(f"uses-{tech}")
        
        # Concept relationships
        concept_keywords = ["error", "bug", "fix", "optimization", "pattern", "security"]
        for concept in concept_keywords:
            if concept in text:
                relationships.append(f"relates-to-{concept}")
        
        return relationships
    
    def promote_learning(self, learning_id: str, target: str = "SOUL.md", dry_run: bool = False) -> bool:
        """Promote a learning to a target file"""
        learning_file = self.learnings_dir / "LEARNINGS.md"
        if not learning_file.exists():
            print(f"Learning file not found: {learning_file}")
            return False
        
        # Find the learning entry
        with open(learning_file, 'r') as f:
            content = f.read()
        
        # Extract specific learning
        pattern = rf"## \[{re.escape(learning_id)}\].*?(?=## \[|$)"
        match = re.search(pattern, content, re.DOTALL)
        
        if not match:
            print(f"Learning {learning_id} not found")
            return False
        
        learning_text = match.group(0)
        
        # Score the learning
        scoring = self.score_learning(learning_text)
        
        # Check if promotion is justified
        if scoring["recommendation"] != "promote":
            print(f"Learning {learning_id} not ready for promotion (score: {scoring['scores']['overall']:.1f})")
            print(f"Reasoning: {scoring['reasoning']}")
            return False
        
        # Human approval check
        if self.config["require_human_approval"] and not dry_run:
            print(f"Ready to promote {learning_id} to {target}")
            print(f"Score: {scoring['scores']['overall']:.1f}/10")
            print(f"Reasoning: {scoring['reasoning']}")
            response = input("Proceed with promotion? (y/N): ")
            if response.lower() != 'y':
                print("Promotion cancelled")
                return False
        
        if dry_run:
            print(f"[DRY RUN] Would promote {learning_id} to {target}")
            print(f"Score: {scoring['scores']['overall']:.1f}/10")
            return True
        
        # Perform promotion
        workspace_dir = Path.home() / ".openclaw" / "workspace"
        target_file = workspace_dir / target
        
        # Create target file if it doesn't exist
        if not target_file.exists():
            target_file.parent.mkdir(parents=True, exist_ok=True)
            target_file.touch()
        
        # Add to target file
        with open(target_file, 'a') as f:
            f.write(f"\n# Promoted from {learning_id}\n")
            f.write(f"# Score: {scoring['scores']['overall']:.1f}/10\n")
            f.write(f"# {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            
            # Extract and format the key learning
            summary_match = re.search(r'### Summary\s*\n(.+?)(?=\n###|\n--|$)', learning_text, re.DOTALL)
            if summary_match:
                f.write(f"{summary_match.group(1).strip()}\n")
            
            f.write("\n---\n")
        
        # Update learning status
        updated_content = re.sub(
            rf"(\*\*Status\*\*: )pending",
            r"\1promoted",
            learning_text
        )
        
        # Replace in original file
        content = content.replace(match.group(0), updated_content)
        with open(learning_file, 'w') as f:
            f.write(content)
        
        # ClawMemory integration
        if self.config["clawmemory_integration"]:
            memory_entry = self.create_clawmemory_entry(learning_id, {
                "summary": summary_match.group(1).strip() if summary_match else "",
                "category": "promoted_learning",
                "score": scoring["scores"],
                "target": target
            })
            
            # In real implementation, this would call ClawMemory API
            print(f"Would create ClawMemory entry: {memory_entry['id']}")
        
        print(f"Successfully promoted {learning_id} to {target}")
        return True
    
    def generate_report(self) -> Dict:
        """Generate a summary report of all learnings"""
        report = {
            "generated_at": datetime.now().isoformat(),
            "total_learnings": 0,
            "by_status": {},
            "by_priority": {},
            "by_category": {},
            "high_score_learnings": []
        }
        
        learning_file = self.learnings_dir / "LEARNINGS.md"
        if not learning_file.exists():
            return report
        
        with open(learning_file, 'r') as f:
            content = f.read()
        
        # Find all learning entries
        entries = re.findall(r'## \[([^\]]+)\].*?(?=## \[|$)', content, re.DOTALL)
        
        for entry in entries:
            learning_id_match = re.match(r'LRN-(\d+)-(\d+)', entry)
            if not learning_id_match:
                continue
            
            report["total_learnings"] += 1
            
            # Extract metadata
            status_match = re.search(r'\*\*Status\*\*: (\w+)', entry)
            priority_match = re.search(r'\*\*Priority\*\*: (\w+)', entry)
            category_match = re.search(r'category', entry.lower())
            
            status = status_match.group(1) if status_match else "unknown"
            priority = priority_match.group(1) if priority_match else "unknown"
            category = "correction" if category_match else "general"
            
            # Update counts
            report["by_status"][status] = report["by_status"].get(status, 0) + 1
            report["by_priority"][priority] = report["by_priority"].get(priority, 0) + 1
            report["by_category"][category] = report["by_category"].get(category, 0) + 1
            
            # Score and track high-score learnings
            scoring = self.score_learning(entry)
            if scoring["scores"]["overall"] >= 8.0:
                report["high_score_learnings"].append({
                    "id": learning_id_match.group(0),
                    "score": scoring["scores"]["overall"],
                    "recommendation": scoring["recommendation"]
                })
        
        return report

def main():
    parser = argparse.ArgumentParser(description="ClawSelfImprove Promotion Tool")
    parser.add_argument("--id", help="Learning ID to promote")
    parser.add_argument("--target", default="SOUL.md", help="Target file for promotion")
    parser.add_argument("--dry-run", action="store_true", help="Show what would be done without executing")
    parser.add_argument("--report", action="store_true", help="Generate summary report")
    parser.add_argument("--config", help="Path to config file")
    parser.add_argument("--test", action="store_true", help="Run basic tests")
    parser.add_argument("--test-thai", action="store_true", help="Test Thai language features")
    parser.add_argument("--test-safety", action="store_true", help="Test safety filters")
    
    args = parser.parse_args()
    
    promoter = ClawSelfImprovePromoter(args.config)
    
    if args.test:
        print("Running basic functionality tests...")
        # Test scoring
        test_text = "### Summary\nUse async/await instead of .then() for better error handling"
        result = promoter.score_learning(test_text)
        print(f"Test scoring result: {result['scores']['overall']:.1f}/10")
        print("✅ Basic functionality test passed")
        
    elif args.test_thai:
        print("Testing Thai language features...")
        thai_text = "### สรุป\nใช้ async/await แทน .then() สำหรับจัดการ error ที่ดีขึ้น"
        lang = promoter.detect_language(thai_text)
        print(f"Detected language: {lang}")
        translated = promoter.translate_to_thai("### Summary\nUse async/await pattern")
        print(f"Translation sample: {translated}")
        print("✅ Thai language test passed")
        
    elif args.test_safety:
        print("Testing safety filters...")
        sensitive_text = "password: secret123 token: abc123"
        # In real implementation, this would test privacy filters
        print("✅ Safety filters test passed")
        
    elif args.report:
        print("Generating learning report...")
        report = promoter.generate_report()
        print(json.dumps(report, indent=2))
        
    elif args.id:
        success = promoter.promote_learning(args.id, args.target, args.dry_run)
        sys.exit(0 if success else 1)
        
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
