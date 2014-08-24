/***
The MIT License (MIT)

Copyright (c) 2014 Tuur Dutoit

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
***/


using Gtk;
using Gdk;
using Granite.Widgets;

namespace Writer.Widgets {
    public class EditorToolBar : Gtk.HeaderBar {
    
        private Editor editor;
        public FontButton font_button;
        public ColorButton font_color_button;
        public ToggleButton bold_button;
        public ToggleButton italic_button;
        public ToggleButton underline_button;
        public ToggleButton strikethrough_button;
        public ModeButton align_button;
    
        public EditorToolBar (Editor editor) {
            this.editor = editor;
            
            this.get_style_context ().add_class ("primary-toolbar");

            var paragraph_combobox = new Gtk.ComboBoxText ();
                paragraph_combobox.append ("Paragraph", ("Paragraph"));
                paragraph_combobox.append ("Heading 1", ("Heading 1"));
                paragraph_combobox.append ("Heading 2", ("Heading 2"));
                paragraph_combobox.append ("Bullet List", ("Bullet List"));
                paragraph_combobox.append ("Dashed List", ("Dashed List"));
                paragraph_combobox.append ("Numbered List", ("Numbered List"));
                paragraph_combobox.set_active_id ("Paragraph");
                
            var font_item = new ToolItem ();
                font_button = new Gtk.FontButton ();
                font_button.use_font = true;
                font_button.use_size = true;
                font_button.font_set.connect (() => {
                    unowned string name = font_button.get_font_name ();
                    stdout.printf ("Selected font: %s\n", name);
                });
                font_item.add (font_button);

            var font_color_button = new Gtk.ColorButton ();
                font_color_button.use_alpha = false;
                
            var styles_item = new ToolItem ();
                var styles_buttons = new ButtonGroup ();
                    bold_button = new Gtk.ToggleButton ();
                        bold_button.add (new Image.from_icon_name ("format-text-bold-symbolic", Gtk.IconSize.BUTTON));
                        bold_button.focus_on_click = false;
                        styles_buttons.pack_start (bold_button);
                    italic_button = new Gtk.ToggleButton ();
                        italic_button.add (new Image.from_icon_name ("format-text-italic-symbolic", Gtk.IconSize.BUTTON));
                        styles_buttons.pack_start (italic_button);
                    underline_button = new Gtk.ToggleButton ();
                        underline_button.add (new Image.from_icon_name ("format-text-underline-symbolic", Gtk.IconSize.BUTTON));
                        styles_buttons.pack_start (underline_button);
                    strikethrough_button = new Gtk.ToggleButton ();
                        strikethrough_button.add (new Image.from_icon_name ("format-text-strikethrough-symbolic", Gtk.IconSize.BUTTON));
                        styles_buttons.pack_start (strikethrough_button);
                styles_item.add (styles_buttons);
                
            var align_item = new ToolItem ();
                align_button = new ModeButton ();
                    align_button.append (new Gtk.Button.from_icon_name ("format-justify-left-symbolic", Gtk.IconSize.BUTTON));
                    align_button.append (new Gtk.Button.from_icon_name ("format-justify-center-symbolic", Gtk.IconSize.BUTTON));
                    align_button.append (new Gtk.Button.from_icon_name ("format-justify-right-symbolic", Gtk.IconSize.BUTTON));
                    align_button.append (new Gtk.Button.from_icon_name ("format-justify-fill-symbolic", Gtk.IconSize.BUTTON));
                align_item.add (align_button);
                
            var insert_combobox = new Gtk.ComboBoxText ();
                insert_combobox.append ("Insert", ("Insert"));
                insert_combobox.append ("Comment", ("Comment"));
                insert_combobox.append ("Hyperlink", ("Hyperlink"));
                insert_combobox.append ("Picture", ("Picture"));
                insert_combobox.append ("Table", ("Table"));
                insert_combobox.set_active_id ("Insert");
            
            
            this.add (paragraph_combobox);
            this.add (font_item);
            this.add (font_color_button);
            this.add (styles_item);
            this.add (align_item);
            this.add (insert_combobox);
            
            align_button.mode_changed.connect (() => {
                change_align (align_button.selected);
            });
            
            font_button.font_set.connect (editor.update_font);
            font_color_button.color_set.connect (editor.update_color);
            
            bold_button.button_press_event.connect ((event) => {
                if (event.type == EventType.BUTTON_PRESS)
                    editor.toggle_style ("bold");
                return false;
            });
            italic_button.button_press_event.connect ((event) => {
                if (event.type == EventType.BUTTON_PRESS)
                    editor.toggle_style ("italic");
                return false;
            });
            underline_button.button_press_event.connect ((event) => {
                if (event.type == EventType.BUTTON_PRESS)
                    editor.toggle_style ("underline");
                return false;
            });
            strikethrough_button.button_press_event.connect ((event) => {
                if (event.type == EventType.BUTTON_PRESS)
                    editor.toggle_style ("strikethrough");
                return false;
            });
            
        }
        
        public void change_align (int index) {
            switch (index) {
                case 1:
                    editor.justify ("center"); break;
                case 2:
                    editor.justify ("right"); break;
                case 3:
                    editor.justify ("fill"); break;
                default:
                    editor.justify ("left"); break;
            }
        }

    }
}