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
using Pango;

namespace Writer {
    public class Editor : TextBuffer {
    
        public TextView text_view;
    
        public Editor () {
            // Add default tags to this TextBuffer's TextTagTable
            setup_tagtable (this);
            text_view = new TextView.with_buffer (this);
        }
        
        
        /*
         * STYLES
         */
         
        public void apply_style (string name) {
            if(this.has_selection) {
                TextIter start; TextIter end;
                this.get_selection_bounds (out start, out end);
                this.apply_tag_by_name (name, start, end);
            }
        }
        
        public void set_font_size (int size) {
            print ("set font size to %d\n", size);
        }
        
        public void make_bold () {
            print ("make selection bold\n");
            apply_style ("bold");
        }
        
        public void make_italic () {
            print ("make selection italic\n");
            apply_style ("italic");
        }
        
        public void make_underline () {
            print ("make selection underlined\n");
            apply_style ("underline");
        }
        
        public void make_strikethrough () {
            print ("make selection strikethrough\n");
        }
        
        public void justify_left () {
            print ("justify text to the left\n");
        }
        
        public void justify_center () {
            print ("justify text to the center\n");
        }
        
        public void justify_right () {
            print ("justify text to the right\n");
        }
        
        public void justify_fill () {
            print ("justify text to fill\n");
        }
        
        
        
        
        // Get a TextTagTable with all the default tags
        private void setup_tagtable (TextBuffer buffer) {
            
            buffer.create_tag ("bold", "weight", 700);
            buffer.create_tag ("italic", "style", Pango.Style.ITALIC);
            buffer.create_tag ("underline", "underline", Pango.Underline.SINGLE);
            
        }
    
    }
}