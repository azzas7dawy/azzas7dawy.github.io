import re

file_path = r'd:\protifio\lib\main.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Update Hero Section Font Sizes
content = re.sub(r'fontSize:\s*isMobile\s*\?\s*20\s*:\s*28', 'fontSize: isMobile ? 16 : 28', content)
content = re.sub(r'fontSize:\s*isMobile\s*\?\s*38\s*:\s*80', 'fontSize: isMobile ? 28 : 80', content)
content = re.sub(r'fontSize:\s*isMobile\s*\?\s*24\s*:\s*40', 'fontSize: isMobile ? 18 : 40', content)
content = re.sub(r'fontSize:\s*isMobile\s*\?\s*16\s*:\s*20', 'fontSize: isMobile ? 14 : 20', content)

# 2. Update About Section
content = re.sub(r'fontSize:\s*24,(\s*fontWeight:\s*FontWeight.bold,\s*color:\s*Colors.white,)', r'fontSize: isMobile ? 20 : 24,\1', content)
content = re.sub(r'fontSize:\s*16,(\s*color:\s*Colors.white70,\s*height:\s*1.6,)', r'fontSize: isMobile ? 14 : 16,\1', content)

# 3. Add isMobile to _buildExperienceSection
content = content.replace('Widget _buildExperienceSection() {', 'Widget _buildExperienceSection() {\n    final isMobile = MediaQuery.of(context).size.width < 900;')

# 4. Update Experience font sizes
content = re.sub(r"fontSize:\s*22,(\s*fontWeight:\s*FontWeight\.bold,\s*color:\s*Colors\.white,)", r"fontSize: isMobile ? 18 : 22,\1", content)
content = re.sub(r"fontSize:\s*18,(\s*color:\s*Color\(0xFFFF2A7F\),\s*fontWeight:\s*FontWeight\.w500,)", r"fontSize: isMobile ? 16 : 18,\1", content)

# 5. Add isMobile to _bulletPoint and update its font size
content = content.replace('Widget _bulletPoint(String text) {', 'Widget _bulletPoint(String text) {\n    final isMobile = MediaQuery.of(context).size.width < 900;')
content = re.sub(r'fontSize:\s*16,(\s*color:\s*Colors.white.withOpacity\(0.8\),\s*height:\s*1.5,)', r'fontSize: isMobile ? 14 : 16,\1', content)

# 6. Update Section Header
content = content.replace('Widget _sectionHeader(String number, String title) {', 'Widget _sectionHeader(String number, String title) {\n    final isMobile = MediaQuery.of(context).size.width < 900;')
content = re.sub(r'fontSize:\s*24,(\s*color:\s*const Color\(0xFFFF8CB3\),\s*fontWeight:\s*FontWeight\.w500,)', r'fontSize: isMobile ? 20 : 24,\1', content)
content = re.sub(r'fontSize:\s*32,(\s*fontWeight:\s*FontWeight\.bold,\s*color:\s*Colors\.white,)', r'fontSize: isMobile ? 24 : 32,\1', content)

# 7. Update Project Showcase Card
content = re.sub(r'fontSize:\s*26,(\s*fontWeight:\s*FontWeight.bold,\s*color:\s*Colors.white,\s*height:\s*1.2,)', r'fontSize: widget.isMobile ? 20 : 26,\1', content)
content = re.sub(r'fontSize:\s*16,(\s*color:\s*Colors.white.withOpacity\(0.8\),\s*height:\s*1.6,)', r'fontSize: widget.isMobile ? 14 : 16,\1', content)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print("Updated font sizes successfully.")
