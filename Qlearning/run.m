world = 1;

gwinit(world)
gwdraw
init_state = gwstate;
% Init Q table
Q = zeros(init_state.xsize,init_state.ysize,4);


Q(:,1,4) = -inf;
Q(:,init_state.ysize,3) = -inf;
Q(1,:,2) = -inf;
Q(init_state.xsize,:,1) = -inf;

%%
prob = 0.7;
%Training phase
for episode = 1:300   
    gwinit(world);
    if(episode == 100)
        gwdraw;
    end
    state = gwstate;
    learning_rate = 0.3;
    gamma = 0.9;

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

