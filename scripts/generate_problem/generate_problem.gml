function generate_problem(_skill, _char) {
    if (is_undefined(_char)) _char = 0; // Default to Addeline if no character is passed

    if (_char == 0) {
        // --- ADDELINE'S MATH ---
        if (_skill == 1) {
            problem_val1 = irandom_range(1, 10); problem_val2 = irandom_range(1, 10);
            problem_question = string(problem_val1) + " + " + string(problem_val2);
            problem_answer = problem_val1 + problem_val2;
        } else if (_skill == 2) {
            problem_val1 = irandom_range(3, 15); problem_val2 = irandom_range(1, problem_val1);
            problem_question = string(problem_val1) + " - " + string(problem_val2);
            problem_answer = problem_val1 - problem_val2;
        } else if (_skill == 3) {
            problem_val1 = irandom_range(1, 5); problem_val2 = irandom_range(1, 5); var c = irandom_range(1, 5);
            problem_question = string(problem_val1) + " + " + string(problem_val2) + " + " + string(c);
            problem_answer = problem_val1 + problem_val2 + c;
        } else if (_skill == 4) {
            problem_val1 = irandom_range(10, 20); problem_val2 = irandom_range(1, 5); var c = irandom_range(1, 5);
            problem_question = string(problem_val1) + " - " + string(problem_val2) + " - " + string(c);
            problem_answer = problem_val1 - problem_val2 - c;
        }
    } else {
        // --- MILLY'S MATH ---
        if (_skill == 1) {
            problem_val1 = irandom_range(2, 9); problem_val2 = irandom_range(2, 9);
            problem_question = string(problem_val1) + " * " + string(problem_val2);
            problem_answer = problem_val1 * problem_val2;
        } else if (_skill == 2) {
            problem_val1 = irandom_range(2, 8); problem_val2 = irandom_range(2, 8); 
            var product = problem_val1 * problem_val2;
            problem_question = string(product) + " / " + string(problem_val1);
            problem_answer = problem_val2;
        } else if (_skill == 3) {
            problem_val1 = irandom_range(2, 5); problem_val2 = irandom_range(1, 5); var c = irandom_range(1, 5);
            problem_question = string(problem_val1) + "(" + string(problem_val2) + " + " + string(c) + ")";
            problem_answer = problem_val1 * (problem_val2 + c);
        } else if (_skill == 4) {
            var odds = [3, 5, 7, 9, 11, 13, 15];
            problem_val1 = odds[irandom(array_length(odds) - 1)];
            problem_question = string(problem_val1) + " / 2";
            problem_answer = problem_val1 / 2; 
        }
    }
}