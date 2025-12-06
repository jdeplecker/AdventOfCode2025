document.querySelector("input").addEventListener("change", function (){
    let fr = new FileReader();
    fr.onload = function () {
        let result = 0;
        let lines = fr.result.split("\n");
        lines.forEach(line => {
            let biggestIndex = 0;
            let biggestNumber = 0;
            for (let i = 0; i < (line.length - 2); i++) {
                if (line[i] > biggestNumber) {
                    biggestIndex = i;
                    biggestNumber = line[i];
                }
            }
            let biggestNumber2 = 0;
            for (let i = biggestIndex + 1; i < (line.length - 1); i++) {
                if (line[i] > biggestNumber2) {
                    biggestNumber2 = line[i];
                }
            }
            result += Number(biggestNumber + biggestNumber2);
            
        });
        console.log("Part 1:", result);                
    }
    fr.readAsText(this.files[0]);
});