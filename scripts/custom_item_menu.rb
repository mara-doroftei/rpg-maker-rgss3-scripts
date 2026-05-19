#==============================================================================
# No True Return Game - Fixed Item Help Text
# Uses the original item window to show navigation controls
#==============================================================================

class Scene_Item < Scene_ItemBase
  CONTROL_TEXT = "ESC - Return     ENTER - Select     < > - Category"

  alias ntr_fixed_item_help_start start
  def start
    ntr_fixed_item_help_start
    setup_fixed_help_window
  end

  alias ntr_fixed_item_help_update update
  def update
    ntr_fixed_item_help_update
    @help_window.set_text(CONTROL_TEXT)
  end

  def setup_fixed_help_window
    @help_window.height = 48
    @help_window.create_contents
    @help_window.set_text(CONTROL_TEXT)

    @category_window.y = @help_window.height
    @item_window.y = @category_window.y + @category_window.height
    @item_window.height = Graphics.height - @item_window.y
    @item_window.refresh
  end
end