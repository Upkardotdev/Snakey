# 🐍 Snakey — A Portable C++ Snake Game using Raylib

### I am still working on code.

Snakey is a lightweight, portable Snake game written in **C++17** using the **Raylib** graphics library.
It’s built to be **self-contained** — no preinstalled libraries needed!

---

## 🚀 Quick Start

### Clone the repo

```bash
git clone https://github.com/Upkardotdev/Snakey.git
cd Snakey
```

### Build and run

```bash
make run
```

That’s it!
Raylib will automatically be cloned and built from source the first time you run it.

---

## 🧩 Project Structure

```
Snakey/
├── Makefile           # Builds Raylib + the game
├── src/               # Your C++ source files
│   └── main.cpp
├── libs/              # Third-party dependencies (Raylib auto-cloned)
│   └── raylib/
├── build/             # Compiled binaries
└── README.md
```

---

## 🧱 Dependencies

Raylib automatically pulls in:

- OpenGL (via Mesa)
- X11 windowing system
- pthread, dl, m libraries

If you’re missing system headers (rare), run:

```bash
sudo apt install build-essential git libgl1-mesa-dev libx11-dev libxcursor-dev libxrandr-dev libxinerama-dev libxi-dev
```

---

## 🧠 Notes for Developers

- Edit your game logic in `src/main.cpp`
- Modify the Makefile if you add more `.cpp` files
- Run `make clean` to rebuild from scratch
- Run `make dist-clean` to remove Raylib too

---

## 🏗️ Roadmap

- [ ] Add score display
- [ ] Add pause menu
- [ ] Add sound effects
- [ ] Add texture-based graphics

---

## 💡 License

This project uses the [zlib/libpng License](https://github.com/raysan5/raylib/blob/master/LICENSE) — same as Raylib.
