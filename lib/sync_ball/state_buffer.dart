part of sync_ball;

class StateBuffer {

  double _ttl;
  List<State> _states = new List<State>();

  StateBuffer({ttl: 0.0}){
    _ttl = ttl;
  }

  void pushState(State state){
    _states.add(state);
    _removeOldStates();
  }

  void _removeOldStates() {
    _states.forEach((state){
      if(state.time < _states.last.time - _ttl){
        _states = new List<State>.from(_states)..remove(state);
      }
    });
  }

  int indexAtTime(double time) {
    int index = 0;

    for(int i = 0; i < _states.length; i++){
      if(_states.elementAt(i).time > time){
        break;
      }
      index = i;
    }

    return index;
  }

  State elementAt(int index){
    if(index < 0){
      return _states.first;
    }

    if(index >= _states.length){
      return _states.last;
    }

    return _states.elementAt(index);
  }

  int get length => _states.length;
}

