#include <stdio.h>
#include <iostream>
#include <string>
#include <optional>
#include "query.h"
#include "lexer.h"
#include "parser.h"
#include "query.cc"

struct BSTNode {
    BSTNode* left;
    BSTNode* right;
    std::string value;
};

void printBT(const std::string& prefix, const BSTNode* node, bool isLeft)
{
    if( node != nullptr )
    {
        std::cout << prefix;

        std::cout << (isLeft ? "├─ " : "└─ " );

        // print the value of the node
        std::cout << node->value << std::endl;

        // enter the next tree level - left and right branch
        printBT( prefix + (isLeft ? "│   " : "    "), node->left, true);
        printBT( prefix + (isLeft ? "│   " : "    "), node->right, false);
    }
}

void printBT(const BSTNode* node)
{
    printBT("", node, false);    
}

std::string getStringByDatatype(DataType* type) {
    switch (type->type)
    {
    case 0: return "INT";
    case 1: return "REAL";
    case 2: return "TEXT";
    case 3: return "CHAR (" + std::to_string(type->integerField) + ")";
    case 4: return "VARCHAR (" + std::to_string(type->integerField) + ")";
    default:
        break;
    }
}

std::string getStringByValue(Value* value) {
    switch (value->type)
    {
    case 0: return std::to_string(value->integerField) + " : INT";
    case 1: return std::to_string(value->doubleField) + " : REAL";
    case 2: return std::string(value->stringField) + " : TEXT";
    default:
        break;
    }
}

BSTNode* expressionToBST(Expression* expression);

BSTNode* logicalExpressionToBSTNode(LogicalExpression* logicalExpression) {
    switch (logicalExpression->type)
    {
    case 0: return new BSTNode { nullptr, nullptr, "TRUE"};
    case 1: return new BSTNode { nullptr, nullptr, "FALSE"};
    case 2: return new BSTNode { logicalExpressionToBSTNode(logicalExpression->leftLogicalExpression), nullptr, "()" };
    case 3: return new BSTNode {
        expressionToBST(logicalExpression->leftExpression),
        expressionToBST(logicalExpression->rightExpression),
        "=="
    };
    case 4: return new BSTNode {
        expressionToBST(logicalExpression->leftExpression),
        expressionToBST(logicalExpression->rightExpression),
        "!="
    };
    case 5: return new BSTNode {
        logicalExpressionToBSTNode(logicalExpression->leftLogicalExpression),
        logicalExpressionToBSTNode(logicalExpression->rightLogicalExpression),
        "OR"
    };
    case 6: return new BSTNode {
        logicalExpressionToBSTNode(logicalExpression->leftLogicalExpression),
        logicalExpressionToBSTNode(logicalExpression->rightLogicalExpression),
        "AND"
    };
    case 7: return new BSTNode {
        logicalExpressionToBSTNode(logicalExpression->leftLogicalExpression),
        nullptr,
        "NOT"
    };
    default:
        break;
    }
}

BSTNode* expressionToBST(Expression* expression) {
    switch (expression->type)
    {
    case 0: return new BSTNode { nullptr, nullptr, std::to_string(expression->integerField)};
    case 1: return new BSTNode { nullptr, nullptr, std::to_string(expression->doubleField)};
    case 2: return new BSTNode { nullptr, nullptr, std::string(expression->stringField)};
    case 3: return new BSTNode { nullptr, nullptr, std::string(expression->stringField)};
    case 4: return logicalExpressionToBSTNode(expression->logicalExpression);
    case 5: return new BSTNode {
        expressionToBST(expression->leftExpression),
        nullptr,
        "()"
    };
    case 6: return new BSTNode {
        expressionToBST(expression->leftExpression),
        expressionToBST(expression->rightExpression),
        "+"
    };
    case 7: return new BSTNode {
        expressionToBST(expression->leftExpression),
        expressionToBST(expression->rightExpression),
        "-"
    };
    case 8: return new BSTNode {
        expressionToBST(expression->leftExpression),
        expressionToBST(expression->rightExpression),
        "*"
    };
    case 9: return new BSTNode {
        expressionToBST(expression->leftExpression),
        expressionToBST(expression->rightExpression),
        "/"
    };
    
    default:
        break;
    }
}

void printDeleteCommand(DeleteCommand* cmd) {
    std::cout << "Запрос: DELETE, таблица " << cmd->stringField << " с условием на удаление: \n";
    if (cmd->deleteCommandCondition->logicalExpression == nullptr) {
        std::cout << "безусловный";
    } else {
        printBT(logicalExpressionToBSTNode(cmd->deleteCommandCondition->logicalExpression));
    }
}

void printCreateCommand(CreateCommand* cmd) {
    std::cout << "Запрос: CREATE, таблица " << cmd->stringField << " с колонками: \n";
    CreateArgs* args = cmd->args;
    while (args != nullptr) {
        std::cout << args->stringField << " с типом " << getStringByDatatype(args->datatype) << " , ";
        args = args->next;
    };
}

void printInsertCommand(InsertCommand* cmd) {
    std::cout << "Запрос: Insert, таблица " << cmd->stringField << " с values: \n";
    InsertArgs* args = cmd->args;
    while (args != nullptr) {
        std::cout << getStringByValue(args->value) << " , ";
        args = args->next;
    }
}

void printSelectCommand(SelectCommand* cmd) {
    std::cout << "Запрос: SELECT, таблица " << cmd->stringField << " с условиями выбора: \n";
    if (cmd->args->selectArgsFields == nullptr) {
        std::cout << "безусловный\n";
    } else {
        SelectArgsFields* args = cmd->args->selectArgsFields;
        while (args != nullptr) {
            printBT(expressionToBST(args->expression));
            args = args->next;
        }
    }
    std::cout << "и логическим выражением:\n";
    printBT(logicalExpressionToBSTNode(cmd->logicalExpression));
}

void printUpdateCommand(UpdateCommand* cmd) {
    std::cout << "Запрос: UPDATE, таблица " << cmd->stringField << " с обновлениями: \n";
    UpdateArgs* args = cmd->args;
    while (args != nullptr) {
        std::cout << args->stringField << " = \n";
        printBT(expressionToBST(args->expression));
        args = args->next;
    }
    std::cout << "и логическим условием на обновление:\n";
    printBT(logicalExpressionToBSTNode(cmd->logicalExpression));
}

void printQuery(Query* query) {
    if (query->createCommand != nullptr) {
        printCreateCommand(query->createCommand);
    }
    if (query->insertCommand != nullptr) {
        printInsertCommand(query->insertCommand);
    }
    if (query->selectCommand != nullptr) {
        printSelectCommand(query->selectCommand);
    }
    if (query->updateCommand != nullptr) {
        printUpdateCommand(query->updateCommand);
    }
    if (query->deleteCommand != nullptr) {
        printDeleteCommand(query->deleteCommand);
    }
    std::cout << '\n';
    if (query->next != nullptr) {
        printQuery(query->next);
    }
}

int main(void) {
    while (1) {
        printf("sql>");
        fflush(stdout);
        fflush(stdin);
        char input[1024];

        if (!fgets(input, sizeof(input), stdin)) {
            break;
        }

        if (input[0] == '\n') {
            continue;
         }

        YY_BUFFER_STATE state;

        if (!(state = yy_scan_bytes(input, strcspn(input, "\n")))) {
            continue;
        }

        Query* ret = new Query();

        if (yyparse(&ret) == 0) {
       //     printf("= %d\n", ret);
        }
        printQuery(ret);

        yy_delete_buffer(state);
    }

    return 0;
}
