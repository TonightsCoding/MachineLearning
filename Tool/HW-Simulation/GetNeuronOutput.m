function [netTerms, output] = GetNeuronOutput(inputs, weights, bias, activation_function_x, activation_function_y)
   
   % input vector have to be a column vector
   sizeInputs = size(inputs);
   if sizeInputs(2) > 1
      inputs = inputs';
   end
   clear sizeInputs
   
   if (length(inputs) ~= length(weights))
      error('input and weight vector have to be the same length.')
   end   
   
   netTerms = weights .* inputs;
   netOutput = sum(netTerms);
   
   % activation function
   activation_function_x = activation_function_x - bias;
   len = length(activation_function_x);
   offset = activation_function_x(1);
   dx = (activation_function_x(end) - activation_function_x(1)) / len; 
   index = round((netOutput - offset) / dx);
   
   if (index <= 0)
      output = activation_function_y(1);
   elseif (index > len)
      output = activation_function_y(end);
   else
      output = activation_function_y(index);
   end
    
end
