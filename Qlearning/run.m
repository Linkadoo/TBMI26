world = 4;

gwinit(world)
gwdraw
init_state = gwstate;
% Init Q table
Q = rand(init_state.xsize,init_state.ysize,4);


Q(:,1,4) = -inf;
Q(:,init_state.ysize,3) = -inf;
Q(1,:,2) = -inf;
Q(init_state.xsize,:,1) = -inf;

%%
num_iteration = 200
learning_rate = 0.3;
gamma = 0.9;
%Training phase
for episode = 1:num_iteration   
    if(episode == num_iteration)
       gwdraw 
    end
    prob = 0.1 + episode/num_iteration * 0.9
    gwinit(world);
    state = gwstate;

    while state.isterminal == 0
        old_state = state;
        action = choose_action(Q,state.pos(1),state.pos(2),[1,2,3,4],...
            [],[0.25,0.25,0.25,0.25],[prob,1-prob]);
        gwplotarrow(old_state.pos,action);
        state = gwaction(action);
        Q(old_state.pos(1),old_state.pos(2),action) = Q(old_state.pos(1),old_state.pos(2),action)+ learning_rate * (state.feedback + gamma*max(Q(state.pos(1),state.pos(2),:),[],3) - Q(old_state.pos(1),old_state.pos(2),action));  
        
       %Update Q table with feedback
    end
end


world = 4;

gwinit(world)
gwdraw
init_state = gwstate;
for x = 1:size(Q,1)
    for y = 1:size(Q,2)
        [temp ,action] = max(Q(x,y,:));
        gwplotarrow([x,y],action);
    end
end    


