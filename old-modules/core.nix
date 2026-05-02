{ config, ... }:
{
  assertions = [
    {
      assertion = config.setup.pluginGroups.niceToHave -> config.setup.pluginGroups.base;
      message = "pluginGroups.niceToHave requires pluginGroups.base";
    }
    {
      assertion = config.setup.pluginGroups.programming -> config.setup.pluginGroups.niceToHave;
      message = "pluginGroups.programming requires pluginGroups.niceToHave";
    }
  ];
}
