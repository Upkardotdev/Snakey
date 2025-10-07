#include "raylib.h"
#include <iostream>
#include <deque>
#include <raymath.h>

int cellSize = 20;
int cellCount = 25;

double lastUpdateTime = 0;

int score = 0;

bool eventTrigerred (double interval) {
    double currentTime = GetTime();
    if(currentTime - lastUpdateTime >= interval){
        lastUpdateTime = currentTime;
        return true;
    }
    return false;
}

class Snake {
    public:
        std::deque<Vector2> snakeBody = {Vector2{5 , 6} , Vector2{4 , 6} , Vector2{3 , 6}};
        enum directionKeys {UP , DOWN , RIGHT , LEFT};
        directionKeys currentDir = RIGHT;


        void draw(){
            for (auto &body : snakeBody){
                Rectangle segment = Rectangle{body.x * cellSize, body.y * cellSize , (float)cellSize , (float)cellSize};
                DrawRectangleRounded(segment , 0.5, 6 , BLACK);
                if(body == snakeBody[0]){
                    DrawRectangleRounded(segment , 0.5 , 6 , RED);
                }
                
            }
        }

        void collition () {
            for(unsigned int i = 1; i < snakeBody.size();i++){
                if (snakeBody[0] == snakeBody[i]){
                    EndDrawing();
                    CloseWindow();
                }
            }
        }

        void keyInput () {
            if(IsKeyPressed(KEY_UP) && currentDir != DOWN) currentDir = UP;
            if(IsKeyPressed(KEY_DOWN) && currentDir != UP) currentDir = DOWN;
            if(IsKeyPressed(KEY_RIGHT) && currentDir != LEFT) currentDir = RIGHT;
            if(IsKeyPressed(KEY_LEFT) && currentDir != RIGHT) currentDir = LEFT;

        }

        void moveSnake () {
           Vector2 dir;
            switch(currentDir){
                case UP:    dir = {0, -1}; break;
                case DOWN:  dir = {0, 1}; break;
                case RIGHT: dir = {1, 0}; break;
                case LEFT:  dir = {-1, 0}; break;
            }
            snakeBody.push_front(Vector2Add(snakeBody[0], dir));
            snakeBody.pop_back();

        }

        void wallcollition () {
                if(snakeBody[0].x < 0 || snakeBody[0].y < 0 || snakeBody[0].x >= cellCount || snakeBody[0].y >= cellCount){
                    EndDrawing();
                    CloseWindow();
                }
        }
};

class Food{
    public:
        Vector2 position = {5 , 6};

        Food (){
            position = randomPos();
        }

        ~Food(){
        }


        void draw(){
            Rectangle segment = Rectangle{position.x * cellSize, position.y * cellSize , (float)cellSize , (float)cellSize};
            DrawRectangleRounded(segment , 0.5 , 6 , GREEN);
        }

        Vector2 randomPos () {
            float x = GetRandomValue(0 , cellCount - 1);
            float y = GetRandomValue(0 , cellCount - 1);
            return Vector2{(float)x , (float)y};
        }

        void eatFood (Snake &snake) {
            if (snake.snakeBody[0] == position){
               position = randomPos();
               snake.snakeBody.push_back(snake.snakeBody.back());
               score++;
            }
        }

        void drawScore () {
            DrawText(TextFormat("Score: %i", score), 10, 10, 25, DARKGRAY);
        }
};


int main () {
    SetRandomSeed(time(0));
    Food food;
    Snake snake;
    

    InitWindow(cellSize * cellCount, cellCount * cellSize , "Snake Game");
    SetTargetFPS(30);
    while (!WindowShouldClose()){
        BeginDrawing();
        snake.keyInput();
        if (eventTrigerred(0.2)) {
            snake.moveSnake();
            food.eatFood(snake);
        }
        snake.collition();
        snake.wallcollition();

        ClearBackground(RAYWHITE);
        food.draw();
        snake.draw();
        food.drawScore();
        EndDrawing();
    }
    CloseWindow();
    return 0;
    
}