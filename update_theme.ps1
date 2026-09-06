$file_path = "d:\protifio\lib\main.dart"
$content = Get-Content -Raw -Path $file_path -Encoding UTF8

# 1. Change global colors to blue theme
$content = $content.Replace("0xFFFF2A7F", "0xFF1976D2")
$content = $content.Replace("0xFFFF8CB3", "0xFF64B5F6")

# 2. Add callback to AnimatedHeroCircle
$circle_class_start = "class AnimatedHeroCircle extends StatefulWidget {"
$circle_class_end = "const AnimatedHeroCircle({super.key});"
$new_circle_class = @"
class AnimatedHeroCircle extends StatefulWidget {
  final VoidCallback? onIconTap;
  const AnimatedHeroCircle({super.key, this.onIconTap});
"@
$content = $content.Replace("$circle_class_start`r`n  $circle_class_end", $new_circle_class)
$content = $content.Replace("$circle_class_start`n  $circle_class_end", $new_circle_class)

# 3. Update the AnimatedHeroCircle usage
$content = $content.Replace("const AnimatedHeroCircle(),", "AnimatedHeroCircle(onIconTap: () => _scrollToSection(_skillsKey)),")

# 4. Wrap icon in GestureDetector in AnimatedHeroCircle
$icon_container = @"
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
"@

$wrapped_icon = @"
child: GestureDetector(
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
                    ),
"@

$content = $content.Replace($icon_container, $wrapped_icon)

Set-Content -Path $file_path -Value $content -Encoding UTF8
Write-Output "Done"
