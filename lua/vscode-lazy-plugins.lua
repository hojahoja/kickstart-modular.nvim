return {
  { -- Modularized setup for plugins that are loaded when inside VScode (CUSTOM)
    require 'kickstart/plugins/mini',
    require 'custom.plugins.multicursor',
    require 'custom.plugins.flash',
    -- { import = 'custom.plugins' },
  },
}
