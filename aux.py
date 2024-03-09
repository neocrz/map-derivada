import json

class Node:
    def __init__(self, name, children=None):
        self.name = name
        self.children = children or []

def parse_input(input_str):
    stack = []
    current_name = ""
    for char in input_str:
        if char == '(':
            stack.append(Node(current_name.strip()))
            current_name = ""
        elif char == ')':
            if current_name:
                stack[-1].children.append(Node(current_name.strip()))
            current_node = stack.pop()
            if stack:
                stack[-1].children.append(current_node)
            else:
                return current_node
            current_name = ""
        elif char == ',':
            if current_name:
                stack[-1].children.append(Node(current_name.strip()))
            current_name = ""
        else:
            current_name += char
    return stack[0]

def node_to_json(node):
    if not node.children:
        return {"name": node.name}
    else:
        return {"name": node.name, "children": [node_to_json(child) for child in node.children]}

def visualize_tree(node, indentation=0):
    result = "    " * indentation + node["name"] + "\n"
    if "children" in node:
        for child in node["children"]:
            result += visualize_tree(child, indentation + 1)
    return result

def main():
    input_str = input("Digite a expressão: ")
    
    parsed_Expr = parse_input(input_str)
    # input_str -> print json
    # json_output = json.dumps(node_to_json(parsed_Expr), indent=4)
    # print(json_output)

    
    # input_str -> Visualization
    parsed_tree = node_to_json(parsed_Expr)
    visualization = visualize_tree(parsed_tree)
    print(visualization)


    # load json -> print visualization
    #parsed_tree = json.loads(json_str)
    #visualization = visualize_tree(parsed_tree)
    #print(visualization)

if __name__ == "__main__":
    main()
