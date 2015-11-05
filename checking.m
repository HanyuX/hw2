function c = checking(script_name)

load([script_name '_checker.mat'], 'check_data');
c = 0;

for i=1:size(check_data,2)
	try
        func = check_data{i}.func;
        n_in = size(func.inputs,2);
        n_out = size(func.outputs,2);
        input = check_data{i}.input;
        output_vars = func.outputs;
        output_size = check_data{i}.output_size;
        for j=1:n_in
            in_args{j} = input.(func.inputs{j});
        end
        [out_args{1:n_out}] = feval(func.name, in_args{:});
        
        fc = 0;
        for j=1:n_out
            if norm(size(out_args{j}) - output_size{j})
                fprintf(1, '%s : WRONG SIZE FOR OUTPUT VARIABLE %s\n', ...
                        func.name, output_vars{j});
                c = c + 1;  %counts number of failures for entire script
                fc = fc + 1;    %counts nuber of failures for this function
            end
        end
        
        if fc > 0
            fprintf(1, '%s failed size tests \n', check_data{i}.func.name);
        else
            fprintf(1, '%s successfully passed size tests \n', check_data{i}.func.name);
        end
        
        clear('in_args');
        clear('out_args');
	catch ME
            c = c + 1;
            fprintf(1, 'cannot execute %s : %s\n', check_data{i}.func.name, ME.message);
	end
end