<?php 
    $input=file_get_contents('php://stdin');
    $lines=explode("\n", $input);

    $reading_ranges = true;
    $valid_numbers = [];
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
        }
    }

    ksort($valid_numbers);
    $result = 0;
    $curr = 0;
    foreach($valid_numbers as $key => $value){
        $start = max($key, $curr + 1);
        $result = $result + max(0, $value - $start + 1);
        $curr = max($curr, $value);
    }

    echo "<br>Part 2:<br>$result of the available ingredient IDs are fresh."
?>