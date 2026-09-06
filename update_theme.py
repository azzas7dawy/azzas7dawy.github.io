import re

file_path = r'd:\protifio\lib\main.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Change global colors to blue theme
content = content.replace('0xFFFF2A7F', '0xFF1976D2')  # Darker blue
content = content.replace('0xFFFF8CB3', '0xFF64B5F6')  # Lighter blue

# 2. Add callback to AnimatedHeroCircle
circle_class_start = 'class AnimatedHeroCircle extends StatefulWidget {'
circle_class_end = 'const AnimatedHeroCircle({super.key});'
new_circle_class = '''class AnimatedHeroCircle extends StatefulWidget {
  final VoidCallback? onIconTap;
  const AnimatedHeroCircle({super.key, this.onIconTap});'''
content = content.replace(circle_class_start + '\n  ' + circle_class_end, new_circle_class)

# 3. Update the AnimatedHeroCircle usage
content = content.replace('const AnimatedHeroCircle(),', 'AnimatedHeroCircle(onIconTap: () => _scrollToSection(_skillsKey)),')

# 4. Wrap icon in GestureDetector in AnimatedHeroCircle
icon_container_regex = r'''(child:\s*Container\(\s*width:\s*50,\s*height:\s*50,\s*decoration:\s*BoxDecoration\(\s*shape:\s*BoxShape.circle,\s*color:\s*const Color\(0xFF1E88E5\),\s*boxShadow:\s*\[\s*BoxShadow\(\s*color:\s*const Color\(0xFF2196F3\).withOpacity\(0.4\),\s*blurRadius:\s*15,\s*spreadRadius:\s*2,\s*\),\s*\],\s*\),\s*child:\s*Icon\(\s*icons\[index\],\s*color:\s*Colors.white,\s*size:\s*24,\s*\),\s*\),)'''

wrapped_icon = '''child: GestureDetector(
                      onTap: widget.onIconTap,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF1E88E5),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2196F3).withOpacity(0.4),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          icons[index],
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),'''
                    
content = re.sub(icon_container_regex, wrapped_icon, content)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Colors and gesture detector updated successfully.")
