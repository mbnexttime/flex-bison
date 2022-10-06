%parse-param {Query**rett}

%code top {
    #include <stdio.h>
    #include "query.h"


    extern int yylex(void);

    static void yyerror(Query **ret, const char* s) {
        fprintf(stderr, "%s\n", s);
    }
}

%union {
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
}


%nterm <logical_expression_t> logical_expression
%nterm <expression_t> expression
%nterm <value_t> value
%nterm <datatype_t> datatype
%nterm <delete_command_t> delete_command
%nterm <delete_command_condition_t> delete_command_condition
%nterm <update_args_t> update_args
%nterm <update_args_t> update_args_list
%nterm <update_command_t> update_command
%nterm <select_args_fields_t> select_args_fields
%nterm <select_args_t> select_args
%nterm <select_command_t> select_command
%nterm <insert_args_t> insert_args_list
%nterm <insert_command_t> insert_command
%nterm <create_args_t> create_table_args_list
%nterm <create_command_t> create_command
%nterm <query_t> commands

%token <integer_field> PLUS MINUS TIMES DIVIDE LPAREN RPAREN
%token <double_field> REAL
%token <integer_field> NUMBER
%token <integer_field> TRUE FALSE OR AND NOT EQUALS NOT_EQUALS
%token <integer_field> SEMICOLON
%token <integer_field> CREATE INSERT UPDATE DELETE SELECT
%token <integer_field> TABLE INTO VALUES FROM WHERE SET
%token <string_field> IDENTIFIER VALUE_STRING
%token <integer_field> POINT
%token <integer_field> DT_INT DT_REAL DT_TEXT DT_CHAR DT_VARCHAR
%token <integer_field> SET_EQUAL

%right SET_EQUAL EQUALS NOT_EQUALS
%left AND OR
%left PLUS MINUS TIMES DIVIDE

%%

total_query: commands { *rett = $1; }

commands: %empty { $$ = nullptr; }
        | create_command commands { $$ = new Query { $2, $1, nullptr, nullptr, nullptr, nullptr}; }
        | insert_command commands { $$ = new Query { $2, nullptr, $1, nullptr, nullptr, nullptr}; }
        | select_command commands { $$ = new Query { $2, nullptr, nullptr, $1, nullptr, nullptr}; }
        | update_command commands { $$ = new Query { $2, nullptr, nullptr, nullptr, $1, nullptr}; }
        | delete_command commands { $$ = new Query { $2, nullptr, nullptr, nullptr, nullptr, $1}; }
        ;

create_command:
        CREATE TABLE IDENTIFIER LPAREN create_table_args_list RPAREN SEMICOLON
        { $$ = new CreateCommand {$3, $5}; };


create_table_args_list: IDENTIFIER datatype { $$ = new CreateArgs {$1, $2, nullptr}; }
        | IDENTIFIER datatype POINT create_table_args_list { $$ = new CreateArgs {$1, $2, $4}; }


insert_command: 
        INSERT INTO IDENTIFIER VALUES LPAREN insert_args_list RPAREN SEMICOLON
        { $$ = new InsertCommand {$3, $6}; };

insert_args_list: value { $$ = new InsertArgs {$1, nullptr}; }
        | value POINT insert_args_list { $$ = new InsertArgs {$1, $3}; }

select_command:
        SELECT select_args FROM IDENTIFIER WHERE logical_expression SEMICOLON
        { $$ = new SelectCommand {$4, $2, $6}; };

select_args_fields: expression { $$ = new SelectArgsFields(); $$->expression = $1; $$->next = nullptr; }
        | expression POINT select_args_fields { $$ = new SelectArgsFields {$1, $3}; }

select_args: select_args_fields { $$ = new SelectArgs(); $$->selectArgsFields = $1; }
        | "*" { $$ = new SelectArgs {nullptr}; }

update_command: 
        UPDATE IDENTIFIER SET update_args_list WHERE logical_expression SEMICOLON 
                { $$ = new UpdateCommand {$2, $4, $6}; }
                
update_args_list: update_args { $$ = $1; }
        |  update_args POINT update_args_list { $3->next = $1; $$ = $3; }

update_args: IDENTIFIER SET_EQUAL expression 
        { $$ = new UpdateArgs(); $$->stringField = $1; $$->expression = $3; $$->next = nullptr; };

delete_command: DELETE FROM IDENTIFIER delete_command_condition SEMICOLON
        { $$ = new DeleteCommand {$3, $4}; };

delete_command_condition: %empty { $$ = new DeleteCommandCondition(); $$->logicalExpression = nullptr; }
        | WHERE logical_expression { $$ = new DeleteCommandCondition(); $$->logicalExpression = $2; }


datatype: DT_INT { $$ = new DataType(); $$->type = 0; }
        | DT_REAL { $$ = new DataType(); $$->type = 1; }
        | DT_TEXT { $$ = new DataType(); $$->type = 2; }
        | DT_CHAR LPAREN NUMBER RPAREN { $$ = new DataType(); $$->type = 3; $$->integerField = $3; }
        | DT_VARCHAR LPAREN NUMBER RPAREN { $$ = new DataType(); $$->type = 4; $$->integerField = $3; }

value: NUMBER { $$ = allocateValue(); $$->type = 0; $$->integerField = $1; }
        | REAL { $$ = allocateValue(); $$->type = 1; $$->doubleField = $1; }
        | VALUE_STRING { $$ = allocateValue(); $$->type = 2; $$->stringField = $1; }

logical_expression: TRUE { $$ = allocateLogicalExpression(); $$->type = 0; }
        | FALSE { $$ = allocateLogicalExpression(); $$->type = 1; } 
        | LPAREN logical_expression RPAREN { $$ = allocateLogicalExpression(); $$->type = 2; $$->leftLogicalExpression = $2; }
        | expression EQUALS expression { $$ = allocateLogicalExpression(); $$->type = 3; $$->leftExpression = $1; $$->rightExpression = $3; }
        | expression NOT_EQUALS expression { $$ = allocateLogicalExpression(); $$->type = 4; $$->leftExpression = $1; $$->rightExpression = $3; }
        | logical_expression OR logical_expression { $$ = allocateLogicalExpression(); $$->type = 5; $$->leftLogicalExpression = $1; $$->rightLogicalExpression = $3; }
        | logical_expression AND logical_expression { $$ = allocateLogicalExpression(); $$->type = 6; $$->leftLogicalExpression = $1; $$->rightLogicalExpression = $3; } 
        | NOT logical_expression { $$ = allocateLogicalExpression(); $$->type = 7; $$->leftLogicalExpression = $2; }

expression: 
        NUMBER { $$ = allocateExpression(); $$->type = 0; $$->integerField = $1; }
        | REAL { $$ = allocateExpression(); $$->type = 1; $$->doubleField = $1; }
        | VALUE_STRING { $$ = allocateExpression(); $$->type = 2; $$->stringField = $1; }
        | IDENTIFIER { $$ = allocateExpression(); $$->type = 3; $$->stringField = $1; }
        | logical_expression { $$ = allocateExpression(); $$->type = 4; $$->logicalExpression = $1; }
        | LPAREN expression RPAREN { $$ = allocateExpression(); $$->type = 5; $$->leftExpression = $2; }
        | expression PLUS expression { $$ = allocateExpression(); $$->type = 6; $$->leftExpression = $1; $$->rightExpression = $3; }
        | expression MINUS expression { $$ = allocateExpression(); $$->type = 7; $$->leftExpression = $1; $$->rightExpression = $3; }
        | expression TIMES expression { $$ = allocateExpression(); $$->type = 8; $$->leftExpression = $1; $$->rightExpression = $3; }
        | expression DIVIDE expression{ $$ = allocateExpression(); $$->type = 9; $$->leftExpression = $1; $$->rightExpression = $3; }
;
