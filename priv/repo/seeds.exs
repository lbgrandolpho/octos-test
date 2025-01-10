alias OctosTest.Repo
alias OctosTest.Accounts.User
alias OctosTest.Devices.Camera

brands = ["Intelbras", "Hikvision", "Giga", "Vivotek"]

1..1000
|> Enum.each(fn _ ->
  is_active = Enum.random([true, false])

  user =
    Repo.insert!(%User{
      name: Faker.Person.PtBr.name(),
      email: Faker.Internet.email(),
      status: if(is_active, do: "active", else: "inactive"),
      deactivated_at:
        if(is_active,
          do: nil,
          else:
            Faker.Date.backward(365)
            |> DateTime.new!(~T[00:00:00])
        )
    })

  Enum.each(1..49, fn _ ->
    Repo.insert!(%Camera{
      brand: Enum.random(brands),
      status:
        if(user.status == "inactive", do: "inactive", else: Enum.random(["active", "inactive"])),
      user_id: user.id
    })
  end)

  if is_active do
    Repo.insert!(%Camera{
      user_id: user.id,
      brand: Enum.random(brands),
      status: "active"
    })
  else
    Repo.insert!(%Camera{
      user_id: user.id,
      brand: Enum.random(brands),
      status: "inactive"
    })
  end
end)
