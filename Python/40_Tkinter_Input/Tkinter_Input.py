# -*- coding: utf-8 -*-
#
#  Tkinter_Input.py
#  
#  Copyright 2017 Holger Lech 
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.


try:
    # Tkinter for Python 2.xx
    import Tkinter as tk    
except:
    # Tkinter for Python 3.xx
    import tkinter as tk



def show_entry_fields():
   print("CAN_ID ( 0- 254 ): %s\nCAN_Msg - Byte 0: %s\nCAN_Msg - Byte 1: %s\nCAN_Msg - Byte 2: %s\nCAN_Msg - Byte 3: %s\nCAN_Msg - Byte 4: %s\nCAN_Msg - Byte 5: %s\nCAN_Msg - Byte 6: %s\nCAN_Msg - Byte 7: %s" %  ( can_id.get(), can_msg_0.get(), can_msg_0.get(),can_msg_1.get(),can_msg_2.get(),can_msg_3.get(),can_msg_4.get(),can_msg_5.get(),can_msg_6.get(),can_msg_7.get()))
   can_id.delete(0,END)
   can_msg_0.delete(0,END)
   can_msg_1.delete(0,END)
   can_msg_2.delete(0,END)
   can_msg_3.delete(0,END)
   can_msg_4.delete(0,END)
   can_msg_5.delete(0,END)
   can_msg_6.delete(0,END)

    
root = tk.Tk()
    
tk.Label(root, text="CAN_ID ( 0- 254 )").grid(row=0)
tk.Label(root, text="CAN_Msg - Byte 0").grid(row=1)
tk.Label(root, text="CAN_Msg - Byte 1").grid(row=2)
tk.Label(root, text="CAN_Msg - Byte 2").grid(row=3)
tk.Label(root, text="CAN_Msg - Byte 3").grid(row=4)
tk.Label(root, text="CAN_Msg - Byte 4").grid(row=5)
tk.Label(root, text="CAN_Msg - Byte 5").grid(row=6)
tk.Label(root, text="CAN_Msg - Byte 6").grid(row=7)
tk.Label(root, text="CAN_Msg - Byte 7").grid(row=8)

can_id = tk.Entry(root)
can_msg_0 = tk.Entry(root)
can_msg_1 = tk.Entry(root)
can_msg_2 = tk.Entry(root)
can_msg_3 = tk.Entry(root)
can_msg_4 = tk.Entry(root)
can_msg_5 = tk.Entry(root)
can_msg_6 = tk.Entry(root)
can_msg_7 = tk.Entry(root)

can_id.grid(row=0, column=1)
can_msg_0.grid(row=1, column=1)
can_msg_0.grid(row=2, column=2)
can_msg_0.grid(row=3, column=3)
can_msg_0.grid(row=4, column=4)
can_msg_0.grid(row=5, column=5)
can_msg_0.grid(row=6, column=6)
can_msg_0.grid(row=7, column=7)
can_msg_0.grid(row=8, column=8)

tk.Button(root, text='Quit', command=root.quit).grid(row=9, column=0, sticky='W', pady=4)
tk.Button(root, text='Show', command=show_entry_fields).grid(row=9, column=1, sticky='W', pady=4)

root.mainloop()
