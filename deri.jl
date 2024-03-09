# implementação em JuliaLang do código Haskell com adições em E() e Exp()
module Derivada

export Expr, Sum, Prod, X, E, Const, Div, Sub, Mul, Exp, Sin, Cos, Tan, Sec, ddx

abstract type Expr end

struct Sum <: Expr
    f::Expr
    g::Expr
end

struct Prod <: Expr
    f::Expr
    g::Expr
end

struct X <: Expr end
struct E <: Expr end

struct Const <: Expr
    k::Float64
end

struct Div <: Expr
    f::Expr
    g::Expr
end

struct Sub <: Expr
    f::Expr
    g::Expr
end

struct Mul <: Expr
    f::Expr
    g::Expr
end

struct Exp <: Expr
    f::Expr
    n::Union{Expr, Int} 
end

struct Sin <: Expr
    f::Expr
end

struct Cos <: Expr
    f::Expr
end

struct Tan <: Expr
    f::Expr
end
struct Sec <: Expr
    f::Expr
end
struct Ln <: Expr
    f::Expr
end

function ddx(expr::Sum)::Expr
    return Sum(ddx(expr.f), ddx(expr.g))
end

function ddx(expr::Prod)::Expr
    return Sum(Prod(ddx(expr.f), expr.g), Prod(expr.f, ddx(expr.g)))
end

function ddx(expr::Div)::Expr
    return Div(Sub(Prod(ddx(expr.f), expr.g), Prod(expr.f, ddx(expr.g))), Prod(expr.g, expr.g))
end

function ddx(expr::Sub)::Expr
    return Sub(ddx(expr.f), ddx(expr.g))
end

function ddx(expr::Cos)::Expr
    return Prod(Const(-1.0), Prod(Sin(expr.f), ddx(expr.f)))
end

function ddx(expr::Sin)::Expr
    return Prod(Cos(expr.f), ddx(expr.f))
end

function ddx(expr::Tan)::Expr
    return Prod(Exp(Sec(expr.f), 2), ddx(expr.f))
end
function ddx(expr::Sec)::Expr
    return Prod(Prod(Sec(expr.f), Tan(expr.f)), ddx(expr.f))
end

function ddx(expr::Ln)::Expr
    return Prod(Div(ddx(expr.f), expr.f), ddx(expr.f))
end

function ddx(expr::Exp)::Expr
    if expr.f isa E && expr.n isa X
        return expr  # não muda caso e^x
    elseif expr.n isa Int
        return Prod(Const(float(expr.n)), Prod(Exp(expr.f, expr.n - 1), ddx(expr.f)))

    elseif expr.n isa Expr
        return Prod(Exp(expr.f, expr.n), ddx(expr.n))
    else
        error("Tipo inválido")
    end
    
end

function ddx(expr::Const)::Expr
    return Const(0.0)
end

function ddx(expr::X)::Expr
    return Const(1.0)
end
function ddx(expr::E)::Expr
    return Const(1.0)
end

end

