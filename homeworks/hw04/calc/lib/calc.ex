## Examples

#  iex> Calc.eval("5 * 1")
#  5

## The loop to repeatedly print a prompt, read one line, eval it, and print the result comes from Professor Nat's notes:
## http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/07-elixir/rw.exs

## The basic idea of how to implement the calculator comes from:
## https://leetcode.com/problems/basic-calculator-iii/discuss/113598/
## which implements a basic calculator in java
defmodule  Calc do
  def eval(exp) do
    exp
    |> data_processing
    |> calculate([],[])
  end

  def data_processing(exp) do
    exp
    |> String.replace(" ", "")
    |> String.codepoints
    |> Enum.chunk_by(&(&1 >= "0"))
    |> Enum.map(&(List.to_string(&1)))
    |> Enum.map(&(split_operator(&1)))
    |> List.flatten()
  end

  def split_operator(chars) do
    if length(chars) > 1 && chars < "0" do
      String.codepoints(chars)
    else
      chars
    end
  end

  def calculate(list,numStack,opStack) do
    if length(list) > 0 do
      [head | tail] = list
      cond do
        is_number(head) ->
          num = String.to_integer(head)
          numStack = numStack ++ [num]
          head == "(" -> opStack = opStack ++ [head]
          head == ")" -> {numStack, opStack} = paren(numStack, opStack)
          head == "+" || head == "-" || head == "*" || head == "/" -> {numStack, opStack} = choose_operator(numStack, opStack, head)
          end
          calculate(tail, numStack, opStack)
          length(tail) == 0 && length(opStack) > 0 ->
            {numStack, opStack} = stack_calculation(numStack, opStack)
            calculate(tail, numStack, opStack)
            length(tail) == 0 && length(opStack) == 0 -> List.first(numStack)
          end
        end

        def is_number(x) do
          if x >= "0" do
            true
          else
            false
          end
        end

        def paren(numStack, opStack) do
          cond do
            List.last(opStack) != "(" ->
              {numStack, opStack} = stack_calculation(numStack, opStack)
              paren(numStack, opStack)
              true ->
                opStack = List.delete_at(opStack, -1)
                {numStack, opStack}
              end
            end

            def choose_operator(numStack, opStack, head) do
              cond do
                length(opStack) > 0 && op_preced(head, List.last(opStack)) ->
                  {numStack, opStack} = stack_calculation(numStack, opStack)
                  choose_operator(numStack, opStack, head)
                  true ->
                    opStack = opStack ++ [head]
                    {numStack, opStack}
                  end
                end

                def stack_calculation(numStack, opStack) do
                  {num1, numStack} = List.pop_at(numStack, -1)
                  {num2, numStack} = List.pop_at(numStack, -1)
                  {op, opStack} = List.pop_at(opStack, -1)
                  numStack = numStack ++ [operation(op, num1, num2)]
                  {numStack, opStack}
                end

                def operation(op, num2, num1) do
                  cond do
                    op == "+" -> num1 + num2
                    op == "-" -> num1 - num2
                    op == "*" -> num1 * num2
                    op == "/" -> Kernel.div(num1, num2)
                  end
                end

                def op_preced(head, last) do
                  cond do
                    Enum.member?(["*", "/"], head) && Enum.member?(["+", "-"], last)
                    -> false
                    last == "(" -> false
                    true -> true
                  end
                end

                def main() do
                  case IO.gets("input: ") do
                    :eof ->
                      IO.puts "All done"
                      {:error, reason} ->
                        IO.puts "Error: #{reason}"
                        line ->
                          IO.puts(eval(line))
                          main()
                        end
                      end
                    end
