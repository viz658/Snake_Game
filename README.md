# FPGA-Based Snake Game Using Artix-7

## Overview
This project is a recreation of the classic Snake game, implemented on an **Artix-7 FPGA** using **Verilog/SystemVerilog**. The game features **VGA output for display**, **PS/2 keyboard support for controls**, and **seven-segment display (SSG) for score tracking**.  

Players control the snake using a keyboard, aiming to eat apples while avoiding collisions with the walls and itself. The game increases in difficulty as the snake grows longer.

## Features
- **Real-time gameplay** using VGA rendering (640x480 resolution).
- **PS/2 keyboard input** for directional control.
- **Dynamic apple placement** using a random coordinate generator.
- **Configurable snake colors** using switches.
- **PWM-controlled LED indicators** for game status (win or lose).
- **Seven-segment display (SSG)** for score status.

---

## Hardware & Tools Used
- **FPGA Board:** Artix-7
- **Peripherals:**
  - VGA Monitor (for game display)
  - PS/2 Keyboard (for snake movement)
  - 7-Segment Display (for score tracking)
  - Onboard LEDs (for difficulty indicators)
  - Swiches (for snake color)
- **Development Tools:**
  - Xilinx Vivado
  - Verilog for hardware description

---

### **1 `top_snake.sv`** (Top-Level Module)
This is the main module that connects all submodules and handles game logic, VGA rendering, input processing, and score tracking.

- Handles game state (running, win, game over).
- Processes PS/2 keyboard inputs for movement.
- Generates VGA signals for real-time game rendering.
- Controls seven-segment display (SSG) for score updates.
- Manages game difficulty based on apple count.

---

### **2 `VGA_gen.sv`** (VGA Driver)
Handles VGA signal generation and provides pixel coordinates for rendering.

---

### **3 `PS2Receiver.sv`** (Keyboard Input Module)
Interfaces with the PS/2 keyboard to decode key presses and output movement directions.

- Reads raw PS/2 scan codes from the keyboard.
- Decodes keyboard into a keycode.
- Outputs a 32-bit keycode

---

### **4 `decoder.sv`** (Keycode to Movement Direction)
Converts the raw PS/2 keyboard keycodes into a movement direction for the snake.

- Maps specific keys (WASD or Arrow keys) to movement directions.
- Outputs a 4-bit signal indicating a movement direction.

---

### **5 `randomGrid.sv`** (Random Apple Placement)
Generates random coordinates for apple placement within the playable area.

- Produces pseudo-random X and Y coordinates.
- Ensures apples do not spawn inside the border*.

---

### **6 `pwm_top.sv`** (PWM LED Controller)
Controls onboard LEDs using Pulse Width Modulation (PWM) to indicate game status.

- Lights up different LEDs when the player wins or loses (green or red).
- Modifies LED brightness dynamically.

---

### **7 `SSG_control.sv`** (Seven-Segment Display Controller)
Drives the seven-segment display (SSG)to show the player's score.

- Displays *pple count as score.
- Updates each digit dynamically.

---

## Possible Improvements
- **Implement AI-controlled Snake Mode** (Self-play).
- **Enhance graphics** with **higher resolution & sprite textures**.
- **Improve Apple Randomization Algorithm** to prevent clustering.

---

## Author
- **[Emmanuel Marcial]** - Developed & implemented the full project.
