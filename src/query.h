#pragma once

#include <string>
#include <utility>

struct LogicalExpression;

struct Expression {
    int type; 
    int integerField;
    char* stringField;
    double doubleField;
    Expression* leftExpression;
    Expression* rightExpression;
    LogicalExpression* logicalExpression;
};

struct LogicalExpression {
    int type;
    Expression* leftExpression;
    Expression* rightExpression;
    LogicalExpression* leftLogicalExpression;
    LogicalExpression* rightLogicalExpression;
};

struct Value {
    int type;
    int integerField;
    char* stringField;
    double doubleField;
};

struct DataType {
    int type;
    int integerField;
};

struct DeleteCommandCondition {
    LogicalExpression* logicalExpression;
};

struct DeleteCommand {
    char* stringField;
    DeleteCommandCondition* deleteCommandCondition;
};

struct UpdateArgs {
    char* stringField;
    Expression* expression;
    UpdateArgs* next;
};

struct UpdateCommand {
    char* stringField;
    UpdateArgs* args;
    LogicalExpression* logicalExpression;
};

struct SelectArgsFields {
    Expression* expression;
    SelectArgsFields* next;
};

struct SelectArgs {
    SelectArgsFields* selectArgsFields;
};

struct SelectCommand {
    char* stringField;
    SelectArgs* args;
    LogicalExpression* logicalExpression;
};

struct InsertArgs {
    Value* value;
    InsertArgs* next;
};

struct InsertCommand {
    char* stringField;
    InsertArgs* args;
};

struct CreateArgs {
    char* stringField;
    DataType* datatype;
    CreateArgs* next;
};

struct CreateCommand {
    char* stringField;
    CreateArgs* args;
};

struct Query {
    Query* next;
    CreateCommand* createCommand;
    InsertCommand* insertCommand;
    SelectCommand* selectCommand;
    UpdateCommand* updateCommand;
    DeleteCommand* deleteCommand;
};

LogicalExpression* allocateLogicalExpression();
Expression* allocateExpression();
Value* allocateValue();
DataType* allocateDataType();
DeleteCommand* allocateDeleteCommand();
DeleteCommandCondition* allocateDeleteCommandCondition();