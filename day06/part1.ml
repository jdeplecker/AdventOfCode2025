let file = "day06/input.txt"

let input_file = In_channel.with_open_text file In_channel.input_all;;
let input_list = String.split_on_char '\n' input_file;;

let rec input2d_list l = match l with
  | [] -> []
  | h :: t -> [List.filter (fun s -> s <> "") (String.split_on_char ' ' h)] @ input2d_list t;;

let problem_solve_col = function
| [] -> 0
| el1::el2::el3::["+"] -> int_of_string el1 + int_of_string el2 + int_of_string el3
| el1::el2::el3::["*"] -> int_of_string el1 * int_of_string el2 * int_of_string el3
| el1::el2::el3::el4::["+"] -> int_of_string el1 + int_of_string el2 + int_of_string el3 + int_of_string el4
| el1::el2::el3::el4::["*"] -> int_of_string el1 * int_of_string el2 * int_of_string el3 * int_of_string el4
| _ -> failwith "error: has no valid elements input";;

let rec problem_solve = function
   | [] :: _ -> []
   | rows -> problem_solve_col (List.map List.hd rows) :: problem_solve (List.map List.tl rows);;
let problem_solve_input = problem_solve (input2d_list input_list);;


let () =
  print_endline (string_of_int (List.fold_left (+) 0 problem_solve_input));;