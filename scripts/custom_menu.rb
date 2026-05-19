#==============================================================================
# Custom Game Menu
# For No True Return
#==============================================================================

#------------------------------------------------------------------------------
# This removes the actor status box from the menu
# and replaces it with a simple controls list.
#------------------------------------------------------------------------------

class Window_MenuControls < Window_Base
  def initialize(x, y, width, height)
    super(x, y, width, height)
    refresh
  end

  def refresh
    contents.clear

    # Big centered title
    contents.font.size = 28
    contents.font.bold = true
    change_color(normal_color)
    draw_text(0, 0, contents.width, 36, "Controls", 1)
    reset_font_settings

    y = 60

    # Normal control text
    contents.font.size = 18
    contents.font.bold = false
    change_color(normal_color)

    draw_text(0, y, contents.width, line_height, "Arrow Keys / ← ↑ → ↓  -  Move", 1)
    y += line_height

    draw_text(0, y, contents.width, line_height, "Enter / Z  -  Confirm", 1)
    y += line_height

    draw_text(0, y, contents.width, line_height, "Esc / X  -  Menu / Back", 1)
    y += line_height

    draw_text(0, y, contents.width, line_height, "Shift  -  Dash", 1)
    y += line_height

    draw_text(0, y, contents.width, line_height, "F12  -  Reset Game", 1)

    reset_font_settings
  end
end

class Scene_Menu < Scene_MenuBase
  def start
    super
    create_command_window
    create_controls_window
  end

  def create_controls_window
    x = @command_window.width
    y = 0
    width = Graphics.width - @command_window.width
    height = Graphics.height
    @controls_window = Window_MenuControls.new(x, y, width, height)
  end
end


#------------------------------------------------------------------------------
# This changes the item category menu.
# It removes Armor and centers Items / Weapons / Key Items.
#------------------------------------------------------------------------------

class Window_ItemCategory < Window_HorzCommand
  def col_max
    return 3
  end

  def make_command_list
    add_command(Vocab::item,     :item)
    add_command(Vocab::weapon,   :weapon)
    add_command(Vocab::key_item, :key_item)
  end

  def draw_item(index)
    rect = item_rect_for_text(index)
    change_color(normal_color, command_enabled?(index))
    draw_text(rect, command_name(index), 1)
  end
end