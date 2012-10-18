describe 'a horse'
  before
    self.horse = new (Horse)

  context 'that is dead'
    before
      self.horse.kill()
  
    it 'should not move'
      self.horse.should not move()