{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    android-studio
    android-tools
    jdk17
  ];

  environment.sessionVariables = {
    ANDROID_HOME = "$HOME/Android/Sdk";
    ANDROID_SDK_ROOT = "$HOME/Android/Sdk";
    JAVA_HOME = "${pkgs.jdk17}";
  };
}
