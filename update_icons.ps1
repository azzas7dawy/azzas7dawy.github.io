$file_path = "d:\protifio\lib\main.dart"
$content = Get-Content -Raw -Path $file_path -Encoding UTF8

$circle_class_start = "class AnimatedHeroCircle extends StatefulWidget {"
$circle_class_end = "const AnimatedHeroCircle({super.key, this.onIconTap});"
$new_circle_class = @"
class AnimatedHeroCircle extends StatefulWidget {
  final void Function(int index)? onIconTap;
  const AnimatedHeroCircle({super.key, this.onIconTap});
"@
$content = $content.Replace("$circle_class_start`n  final VoidCallback? onIconTap;`n  $circle_class_end", $new_circle_class)
$content = $content.Replace("$circle_class_start`r`n  final VoidCallback? onIconTap;`r`n  $circle_class_end", $new_circle_class)

$old_usage = "AnimatedHeroCircle(onIconTap: () => _scrollToSection(_skillsKey)),"
$new_usage = @"
AnimatedHeroCircle(
                onIconTap: (index) {
                  switch (index % 5) {
                    case 0:
                      _scrollToSection(_aboutKey);
                      break;
                    case 1:
                      _scrollToSection(_experienceKey);
                      break;
                    case 2:
                      _scrollToSection(_skillsKey);
                      break;
                    case 3:
                      _scrollToSection(_projectsKey);
                      break;
                    case 4:
                      _scrollToSection(_contactKey);
                      break;
                  }
                },
              ),
"@
$content = $content.Replace($old_usage, $new_usage)

$old_gesture = "onTap: widget.onIconTap,"
$new_gesture = "onTap: () => widget.onIconTap?.call(index),"
$content = $content.Replace($old_gesture, $new_gesture)

Set-Content -Path $file_path -Value $content -Encoding UTF8
Write-Output "Done"
