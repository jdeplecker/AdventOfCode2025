<?php 
    $input=file_get_contents('php://stdin');
    $lines=explode("\n", $input);

    $reading_ranges = true;
    $valid_numbers = [];
    $result = 0;
    foreach ($lines as $line) {
        if (empty($line)) {
            $reading_ranges = false;
        } else if ($reading_ranges) {
            list($start, $end) = explode("-", $line);
            if (empty($valid_numbers[$start])) {
                $valid_numbers[$start] = $end;
            } else {
                $valid_numbers[$start] = max($end, $valid_numbers[$start]);
            }
        } else {
            foreach($valid_numbers as $key => $value){
                if ($key <= $line && $line <= $value) {
                    $result++;
                    break;
                }
            }
        }
    }
    echo "<br>Part 1:<br>$result of the available ingredient IDs are fresh."
?>