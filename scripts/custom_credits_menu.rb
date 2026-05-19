#==============================================================================
# No True Return - Credits Menu
# Adds a Credits option to the main menu.
# Credits can be scrolled with UP / DOWN.
#==============================================================================


#==============================================================================
# 1. ADD "CREDITS" TO THE MAIN MENU
#==============================================================================

class Window_MenuCommand < Window_Command
  alias ntr_add_credits_command add_original_commands

  def add_original_commands
    ntr_add_credits_command

    # This adds the Credits button to the normal menu.
    add_command("Credits", :credits)
  end
end


#==============================================================================
# 2. MAKE THE CREDITS BUTTON OPEN THE CREDITS SCREEN
#==============================================================================

class Scene_Menu < Scene_MenuBase
  alias ntr_create_command_window_credits create_command_window

  def create_command_window
    ntr_create_command_window_credits

    # When the player selects Credits, it opens Scene_Credits.
    @command_window.set_handler(:credits, method(:command_credits))
  end

  def command_credits
    SceneManager.call(Scene_Credits)
  end
end


#==============================================================================
# 3. CREDITS SCREEN
#==============================================================================

class Scene_Credits < Scene_MenuBase
  def start
    super
    create_credits_window
  end

  def create_credits_window
    @credits_window = Window_Credits.new
  end

  def update
    super

    # These lines make the credits scroll with UP and DOWN.
    if Input.repeat?(:DOWN)
      @credits_window.scroll_down
    elsif Input.repeat?(:UP)
      @credits_window.scroll_up
    end

    # ESC / X returns to the menu.
    if Input.trigger?(:B)
      Sound.play_cancel
      SceneManager.return
    end
  end
end


#==============================================================================
# 4. CREDITS WINDOW
#==============================================================================

class Window_Credits < Window_Base

  # This controls how fast the credits scroll.
  # Higher number = faster scrolling.
  SCROLL_SPEED = 8

  def initialize
    super(0, 0, Graphics.width, Graphics.height)
    refresh
  end

  # This controls how tall the scrollable credits area is.
  # If you add many credits and they do not fit, increase this number.
  def contents_height
    return 1200
  end

  # Scroll down, but do not go past the bottom.
  def scroll_down
    max_scroll = contents.height - height + standard_padding * 2
    self.oy += SCROLL_SPEED
    self.oy = max_scroll if self.oy > max_scroll
  end

  # Scroll up, but do not go above the top.
  def scroll_up
    self.oy -= SCROLL_SPEED
    self.oy = 0 if self.oy < 0
  end

  # This is where the credits text is drawn.
  # Add your credits here by copying the category + entry pattern.
  def refresh
    contents.clear
    y = 0

    draw_big_title("Credits", y)
    y += 70


    #--------------------------------------------------------------------------
    # GAME DESIGN & STORY
    # Add the main creator / writer here.
    #--------------------------------------------------------------------------

    draw_category("Game Design & Story", y)
    y += 40
    draw_entry("...", y)
    y += 28
    draw_entry("...", y)
    y += 60


    #--------------------------------------------------------------------------
    # GRAPHICS & TILESETS
    # Add tilesets, sprites, character graphics, map assets, etc.
    #--------------------------------------------------------------------------

    draw_category("Graphics & Tilesets", y)
    y += 40
    draw_entry("...", y)
    y += 28
    draw_entry("...", y)
    y += 28
    draw_entry("...", y)
    y += 60


    #--------------------------------------------------------------------------
    # TITLE ARTWORK & ILLUSTRATIONS
    # Add title screen image, intro image, portraits, generated artwork, etc.
    #--------------------------------------------------------------------------

    draw_category("Title Artwork & Illustrations", y)
    y += 40
    draw_entry("...", y)
    y += 28
    draw_entry("...", y)
    y += 60


    #--------------------------------------------------------------------------
    # BACKGROUND MUSIC & SOUND DESIGN
    # Add music creators, ambience, sound effects, etc.
    #--------------------------------------------------------------------------

    draw_category("Background Music & Sound Design", y)
    y += 40
    draw_entry("...", y)
    y += 28
    draw_entry("...", y)
    y += 28
    draw_entry("...", y)
    y += 60


    #--------------------------------------------------------------------------
    # SPECIAL THANKS
    # Add people, communities, testers, friends, etc.
    #--------------------------------------------------------------------------

    draw_category("Special Thanks", y)
    y += 40
    draw_entry("...", y)
    y += 28
    draw_entry("...", y)
    y += 80


    #--------------------------------------------------------------------------
    # CONTROLS NOTE
    # This tells the player how to leave and scroll the credits.
    #--------------------------------------------------------------------------

    draw_small_note("Use UP / DOWN to scroll", y)
    y += 28
    draw_small_note("Press ESC to return", y)
  end


  #============================================================================
  # TEXT DRAWING METHODS
  # You usually do not need to edit these.
  # They control font size, bold text, and text color.
  #============================================================================

  def draw_big_title(text, y)
    contents.font.size = 30
    contents.font.bold = true
    change_color(normal_color)
    draw_text(0, y, contents.width, 40, text, 1)
    reset_font_settings
  end

  def draw_category(text, y)
    contents.font.size = 24
    contents.font.bold = true
    change_color(normal_color)
    draw_text(0, y, contents.width, 32, text, 1)
    reset_font_settings
  end

  def draw_entry(text, y)
    contents.font.size = 18
    contents.font.bold = false
    change_color(normal_color)
    draw_text(0, y, contents.width, 26, text, 1)
    reset_font_settings
  end

  def draw_small_note(text, y)
    contents.font.size = 16
    contents.font.bold = false
    change_color(normal_color)
    draw_text(0, y, contents.width, 24, text, 1)
    reset_font_settings
  end
end