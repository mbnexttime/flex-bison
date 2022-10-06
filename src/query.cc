#pragma once
#include "query.h"
#include <stdio.h>

LogicalExpression* allocateLogicalExpression() {
    return new LogicalExpression();
}

Expression* allocateExpression() {
    return new Expression();
}

Value* allocateValue() {
    return new Value();
}

DataType* allocateDataType() {
    return new DataType();
}

DeleteCommand* allocateDeleteCommand() {
    return new DeleteCommand();
}

DeleteCommandCondition* allocateDeleteCommandCondition() {
    return new DeleteCommandCondition();
}