package chap11;

import stone.ast.ParameterList;
import stone.ast.BlockStmnt;
import chap6.Environment;
import chap7.Function;

public class OptFunction extends Function {
    protected int size;
    public OptFunction(ParameterList params, BlockStmnt body, Environment env,
                       int memorySize) {
        super(params, body, env);
        size = memorySize;
    }
    public Environment makeEnv() { return new ArrayEnv(size, env); }
}
