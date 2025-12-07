let file = "day06/input.txt"

let input_file = In_channel.with_open_text file In_channel.input_all;;
let input_list = String.split_on_char '\n' input_file;;

let rec input2d_list l = match l with
  | [] -> []
  | h :: t -> [List.init (String.length h) (String.get h)] @ input2d_list t;;

let num_extract el = String.sub el 1 (String.length el - 1);;

let problem_solve_col = function
| [] -> 0
| el1::el2::el3::el4::[] -> 
    if el1.[0] = '+' then
      int_of_string (num_extract el1) + int_of_string el2 + int_of_string el3 + int_of_string el4
    else
      int_of_string (num_extract el1) * int_of_string el2 * int_of_string el3 * int_of_string el4
| el1::el2::el3::[] ->
    if el1.[0] = '+' then
      int_of_string (num_extract el1) + int_of_string el2 + int_of_string el3
    else
      int_of_string (num_extract el1) * int_of_string el2 * int_of_string el3
| el1::el2::[] ->
    if el1.[0] = '+' then
      int_of_string (num_extract el1) + int_of_string el2
    else
      int_of_string (num_extract el1) * int_of_string el2
| t -> failwith ("error: has no valid elements input " ^ (String.concat "->" t));;

let rec transpose = function
   | [] :: _ -> []
   | rows -> List.map List.hd rows :: transpose (List.map List.tl rows);;
let transposed_input = transpose (input2d_list input_list);;
let char_to_string = List.map (fun lc -> List.map (fun c -> String.make 1 c) lc);;

let rec make_col_numbers = function
| [] -> ""
| c::[] -> c
| c::[" "] -> c
| c::["*"] -> "*" ^ c
| c::["+"] -> "+" ^ c
| c::" "::t -> make_col_numbers ([c] @ t)
| " "::t -> make_col_numbers t
| ""::t -> make_col_numbers t
| c1::c2::t -> make_col_numbers ([c1 ^ c2] @ t);;

let col_numbers_input = List.map make_col_numbers (char_to_string transposed_input);;

let split_on_space lst =
  let rec aux current acc = function
    | [] ->
        let acc =
          if current = [] then acc else List.rev current :: acc
        in
        List.rev acc
    | " " :: xs ->
        let acc =
          if current = [] then acc else List.rev current :: acc
        in
        aux [] acc xs
    | x :: xs ->
        aux (x :: current) acc xs
  in
  aux [] [] lst

let () =
  print_endline (string_of_int (List.fold_left (+) 0 (List.map problem_solve_col (split_on_space col_numbers_input))));;