function PersonID_x_AboveAtExam = persons_above_interpolated( persons, vector_measure, date_measure, threshold)
    % SUMMARY: persons_above computes for each unique person if they are above the
    %threshold at a given day.
    %
    % OUTPUT:: PersonID_x_AboveAtExam : Returns a unique_persons by
            % first_date_of_measure_to_last_date_of_measure matrix with value 1 if above
            % the threshold and 0 else.
    % INPUT::
        % persons: a vector of cells of personID strings,
        % vector_measure: a vector of numeric values, where value at row x
        % corresponds to person at row x.
        % date_measure: a vector of dates in integer form, where value at row x
        % corresponds to measure at row x.
        % threshold: a threshold above which the state is 1.

    egos = unique(persons); % different persons
    duration = max(date_measure)-min(date_measure) + 1; % Time elapsed from first measurement (inclusive) to last measurement (inclusive)
    date_measure = date_measure - min(date_measure) + 1; % normalize date_weight

    PersonID_x_AboveAtExam = zeros(length(egos),duration); % make empty

    %warning('off', 'MATLAB:polyfit:RepeatedPointsOrRescale'); % temporarly turn off those warnings about badly conditioned polynomials

    for i= 1:length(egos)
        personInd = find(ismember(persons,egos(i))); % personInd = person indexes

        measureDateEgo = date_measure(personInd); % We need the indexes corresponding to a person sorted by date, in order to compute the final matrix in one pass per person.
        dates_measures = [measureDateEgo, personInd]; % Prepend date vector to index vector
        dates_measures = sortrows(dates_measures); % Sort after date vector
        mbd = dates_measures(:,2); % extract sorted by date index vector of the measures i.e. MeasuresByDate
        measureDateEgo = dates_measures(:,1); % dates sorted

        person_measures = vector_measure(mbd); % all the measures of an ego
        % remove multiple measurements that were taken on the same day to
        % avoid badly conditioned polynomial
        [measureDateEgo, index_measureDateEgo, ~] = unique(measureDateEgo,'stable');
        person_measures = person_measures(index_measureDateEgo);
        measure_count = length(measureDateEgo);
        degree = min(measure_count-1, 1); % restrict polynom to degree <= 2 to avoid edge effects
        p = polyfit(measureDateEgo,person_measures,degree);
        x = 1:duration;
        y = polyval(p,x);
        plot(x,y);


        y(y <= threshold) = 0; % binary matrix: 0 -> value below threshold at this date for this person
        y(y > threshold) = 1; % binary matrix: 1 -> value above or equal threshold at this date for this person
        PersonID_x_AboveAtExam(i,:) = y;
    end
end
