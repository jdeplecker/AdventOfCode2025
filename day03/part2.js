function indexNumber(line, start, max) {
    let biggestIndex = 0;
    let biggestNumber = 0;
    for (let i = start; i < max; i++) {
        if (line[i] > biggestNumber) {
            biggestIndex = i;
            biggestNumber = line[i];
        }
    }
    return [biggestIndex, biggestNumber];
}

document.querySelector("input").addEventListener("change", function (){
    let fr = new FileReader();
    fr.onload = function () {
        let result = 0;
        let lines = fr.result.split("\n");
        lines.forEach(line => {                    
            let amountDigits = 12;
            let digitsStr = "";
            let biggestIndex = 0;
            for (let i = 0; i < amountDigits; i++) {
                let inr = indexNumber(line, biggestIndex, line.length - amountDigits + i + 1);
                biggestIndex = inr[0] + 1;
                digitsStr += inr[1];
            }
            result += Number(digitsStr);
            
        });
        console.log("Part 2:", result);                
    }
    fr.readAsText(this.files[0]);
});