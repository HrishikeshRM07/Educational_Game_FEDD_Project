function generate_problem(skill)
{
    switch(skill)
    {
        case 1: // Additive Power (Heal One)
            var a = irandom_range(1,10);
            var b = irandom_range(1,10);
            problem_question = string(a) + " + " + string(b);
            problem_answer = a + b;
        break;
        
        case 2: // Subtraction (Damage One)
            var a = irandom_range(3,15);
            var b = irandom_range(1,a);
            problem_question = string(a) + " - " + string(b);
            problem_answer = a - b;
        break;
        
        case 3: // Commutative (Party Heal)
            var a = irandom_range(1,5);
            var b = irandom_range(1,5);
            var c = irandom_range(1,5);
            problem_question = string(a) + " + " + string(b) + " + " + string(c);
            problem_answer = a + b + c;
        break;
        
        case 4: // Double Subtraction (Multi Attack)
            var a = irandom_range(10,20);
            var b = irandom_range(1,5);
            var c = irandom_range(1,5);
            problem_question = string(a) + " - " + string(b) + " - " + string(c);
            problem_answer = a - b - c;
        break;
    }
}