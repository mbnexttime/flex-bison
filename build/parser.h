/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_HOME_KGAVRILOV_FLEX_HW_2_BUILD_PARSER_H_INCLUDED
# define YY_YY_HOME_KGAVRILOV_FLEX_HW_2_BUILD_PARSER_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    PLUS = 258,
    MINUS = 259,
    TIMES = 260,
    DIVIDE = 261,
    LPAREN = 262,
    RPAREN = 263,
    REAL = 264,
    NUMBER = 265,
    TRUE = 266,
    FALSE = 267,
    OR = 268,
    AND = 269,
    NOT = 270,
    EQUALS = 271,
    NOT_EQUALS = 272,
    SEMICOLON = 273,
    CREATE = 274,
    INSERT = 275,
    UPDATE = 276,
    DELETE = 277,
    SELECT = 278,
    TABLE = 279,
    INTO = 280,
    VALUES = 281,
    FROM = 282,
    WHERE = 283,
    SET = 284,
    IDENTIFIER = 285,
    VALUE_STRING = 286,
    POINT = 287,
    DT_INT = 288,
    DT_REAL = 289,
    DT_TEXT = 290,
    DT_CHAR = 291,
    DT_VARCHAR = 292,
    SET_EQUAL = 293
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 15 "/home/kgavrilov/flex/hw_2/src/parser.y"

    char* string_field;
    int integer_field;
    double double_field;
    Expression* expression_t;
    LogicalExpression* logical_expression_t;
    Value* value_t;
    DataType* datatype_t;
    DeleteCommand* delete_command_t;
    DeleteCommandCondition* delete_command_condition_t;
    UpdateArgs* update_args_t;
    UpdateCommand* update_command_t;
    SelectArgs* select_args_t;
    SelectArgsFields* select_args_fields_t;
    SelectCommand* select_command_t;
    InsertArgs* insert_args_t;
    InsertCommand* insert_command_t;
    CreateArgs* create_args_t;
    CreateCommand* create_command_t;
    Query* query_t;

#line 118 "/home/kgavrilov/flex/hw_2/build/parser.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (Query**rett);

#endif /* !YY_YY_HOME_KGAVRILOV_FLEX_HW_2_BUILD_PARSER_H_INCLUDED  */
