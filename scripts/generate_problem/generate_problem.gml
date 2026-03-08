function generate_problem(skill)
{
    switch(skill)
    {
        case 1: // Additive Power (Heal One)
            problem_val1 = irandom_range(1, 10);
            problem_val2 = irandom_range(1, 10);
            problem_question = string(problem_val1) + " + " + string(problem_val2);
            problem_answer = problem_val1 + problem_val2;
        break;
        
        case 2: // Subtraction (Damage One)
            problem_val1 = irandom_range(3, 15);
            problem_val2 = irandom_range(1, problem_val1);
            problem_question = string(problem_val1) + " - " + string(problem_val2);
            problem_answer = problem_val1 - problem_val2;
        break;
        
        case 3: // Commutative (Party Heal)
            var a = irandom_range(1, 5);
            var b = irandom_range(1, 5);
            var c = irandom_range(1, 5);
            problem_val1 = a;
            problem_val2 = b + c; // We combine these so the Fairy hint makes sense
            problem_question = string(a) + " + " + string(b) + " + " + string(c);
            problem_answer = a + b + c;
        break;
        
        case 4: // Double Subtraction (Multi Attack)
            problem_val1 = irandom_range(10, 20);
            var b = irandom_range(1, 5);
            var c = irandom_range(1, 5);
            problem_val2 = b; // We store the first 'take away' for the hint
            problem_question = string(problem_val1) + " - " + string(b) + " - " + string(c);
            problem_answer = problem_val1 - b - c;
        break;
    }
}