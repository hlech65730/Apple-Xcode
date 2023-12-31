# OS : Raspbian "Buster"( Debian 10 )
# Python 3.7
# Erstes Fenster des Tkinter
# aus https://www.python-kurs.eu/tkinter_labels.php
# -*- coding: utf-8 -*-

try:
    # Tkinter for Python 2.xx
    import Tkinter as tk
except:
    # Tkinter for Python 3.xx
    import tkinter as tk

# definition of function upper radio button pressed which creates a picture in the window. The picture is in file  Rechteck_gelb_mit_Punkt_blau.gif
# see definiton of blue_img on the bottom of this script 
def upper_radio_button_pressed():
  canvas.create_image(20,20, anchor='nw', image=blue_img)
 
 # definition of function upper radio button pressed which creates a picture in the window. The picture is in file  Rechteck_gelb_mit_Punkt_rot.gif
# see definiton of red_img on the bottom of this script  
def lower_radio_button_pressed():
  canvas.create_image(20,20, anchor='nw', image=red_img)


# definition of class App which is handling the Quit  and the hello Button
class App:
  def __init__(self, master):
    frame = Frame(master)
    frame.pack()
    self.button = Button(frame, 
                         text="QUIT", fg="red",
                         command=frame.quit)
    self.button.pack(side=LEFT)
    
    self.slogan = Button(frame,
                         text="Hello",
                         command=self.write_slogan)
    self.slogan.pack(side=LEFT)
    
  def write_slogan(self): # definition of function write slogan. The text is written in the command line box only if the button Hello is pressed.
    print ("Tkinter is easy to use!")

# Tkinter window definition
root = tk.Tk() 
root.title("First python Tkinter window") 

# width x height + x_offset + y_offset:
root.geometry("500x600+30+30") 

# define red label inside the window with text  "red Label"
w = tk.Label(root, text="Red Label", bg="red", fg="white")

# automatic managing of geometrie ( pack manager )of label w  inside of the window
# means x coordinate is done automatically and Y coordinate is given ( for x use padx =...) 
w.pack(fill='x',pady=10)

# integer variable definition 
v = tk.IntVar()

entry1 = tk.Entry(root)
entry2 = tk.Entry(root)


# definition of Label "Choose a programming language"
tk.Label(root, 
      text="""Choose a programming language:""",
      #justify = LEFT,
      padx = 20).pack()

      
 # definition of pushable radiobuttons with text  Phyton or Perl
tk.Radiobutton(root, 
            text="Python",
            padx = 20, 
            variable=v, 
            value=1,
            command=upper_radio_button_pressed).pack(anchor='w' ) # call the function upper_radio_button pressed
            
tk.Radiobutton(root, 
            text="Perl",
            padx = 20, 
            variable=v, 
            value=2,
            command=lower_radio_button_pressed).pack(anchor='w' )# call the function upper_radio_button pressed

# a canvas is a graphical object, here blue_img and red_img 
# define the dimensions of the pictures  inside of the window and that it is shown inside of the window root 

canvas_width = 200
canvas_height = 100
canvas = tk.Canvas(root, 
           width=canvas_width, 
           height=canvas_height)
canvas.pack()


#definition of picture blue_img 
blue_img = tk.PhotoImage(file="//home//pi//Repositories//Raspberry-Pi//Python//30_Tkinter_Tutorial//20_Pictures//30_PPM//Quadrat_gelb_mit Smilie.PPM")
#definition of picture red_img 
red_img = tk.PhotoImage(file="//home//pi//Repositories//Raspberry-Pi//Python//30_Tkinter_Tutorial//20_Pictures//20_Gif//Rechteck_gelb_mit_Punkt_rot.gif")


# call of the class App with parameter root for the window
app = tk.Tk()

tk.Label(root,text="Vorname:").pack()
vorname = entry1.pack()

tk.Label(root,text="Nachnahme:").pack()
nachname = entry2.pack()

#start window loop
tk.mainloop()

print(vorname)
print(nachname)
