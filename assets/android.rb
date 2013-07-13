module Jmi
  module J
    module Com
      module Github
        module Wanabe
          class Andruboid
          end
        end
      end
    end
    module Java
      module Lang
        class CharSequence < Jmi::Object
          include AsString
        end
        class String < CharSequence
        end
      end
      module Util
        module List
          extend Generics
          attach Int, "size"
          attach Generics, "get", Int
        end
      end
    end
    module Android
      module Content
        class Context
        end
        module Pm
          class PackageManager < Jmi::Object
          end
          class ApplicationInfo < Jmi::Object
            attach Java::Lang::CharSequence, "load_description", PackageManager
            attach Java::Lang::String, "to_string"
          end
          class PackageManager < Jmi::Object
            attach Java::Util::List[ApplicationInfo], "get_installed_applications", Int
          end
        end
      end
      module View
        class View
          module OnClickListener
          end
        end
      end
      module Widget
        class LinearLayout < Jmi::Object
          attach_init Android::Content::Context
          attach Void, ["add_view", "<<"], Android::View::View
        end
        class TextView < Jmi::Object
          attach_init Android::Content::Context
          attach Void, "set_text", Java::Lang::CharSequence
        end
        class Button < Jmi::Object
          attach_init Android::Content::Context
          attach Void, "set_text", Java::Lang::CharSequence
          attach Void, "set_on_click_listener", Android::View::View::OnClickListener
        end
        class Toast < Jmi::Object
          attach_const Int, "LENGTH_SHORT"
          attach_const Int, "LENGTH_LONG"
          attach_static Toast, "make_text", Android::Content::Context, Java::Lang::CharSequence, Int
          attach Void, "show"
        end
        class CheckBox < Jmi::Object
          attach_init Android::Content::Context
          attach Void, "set_checked", Bool
          attach Bool, "is_checked"
          attach Void, "set_on_click_listener", Android::View::View::OnClickListener
        end
      end
      module App
        class Activity < Jmi::Object
          attach Void, "set_content_view", Android::View::View
          attach Android::Content::Pm::PackageManager, "get_package_manager"
        end
      end
    end
  end

  class Main < J::Android::App::Activity
    def initialize
      Jmi::Main.main = self
    end
    class << self
      attr_accessor :main
      def inherited(main)
        super
        @main = main
      end
    end
  end

  class ClickListener < Jmi::Object.force_path("com/github/wanabe/Andruboid$ClickListener")
    @table = []
    attach_init Com::Github::Wanabe::Andruboid,Int
    def initialize(&block)
      klass = self.class
      id = klass.push block
      super Jmi::Main.main, id
    end
    class << self
      def push(block)
        id = @table.size
        @table.push block
        id
      end
      def call(id)
        @table[id].call
      end
    end
  end
end

