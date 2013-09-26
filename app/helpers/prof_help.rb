def fake_years
  rand(1..10)
end

def fake_formal
  [true, false, false].sample
end

def fake_skills
  rand(Skill.all.count) + 1
end


