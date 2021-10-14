SRC = \
src/main.c \
src/drv/int1/returnint1.c \
# src/drv/int2/returnint2.c \
# src/drv/int3/returnint3.c \
# src/api/num1/returnnum1.c \
# src/api/num2/returnnum2.c \
# src/api/num3/returnnum3.c \
# src/example.c 

INC = \
-I. \
-Isrc/drv/int1 \
# -Isrc/drv/int2 \
# -Isrc/drv/int3 \
# -Isrc/api/num1 \
# -Isrc/api/num2 \
# -Isrc/api/num3 \


all:
	gcc $(SRC) $(INC) -o out