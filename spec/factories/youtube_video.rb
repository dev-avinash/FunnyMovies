FactoryBot.define do
  factory :youtube_video do
    # [Tanuj]: Here I'm hardcoding url, title and description, because title and description are fetched via
    # background jobs so to validate testcases I have keep them constant.
    user
    url { 'https://www.youtube.com/watch?v=SWjg8ck_Qf4' }
    title { 'Highlights from Microsoft’s October 2018 event' }
    description { 'Announcing exciting new Surface devices, including Surface Pro 6, Surface Laptop 2, Surface Studio 2 and Surface Headphones, the launch of the Windows 10 October 2018 Update and innovative new Office features – all designed to empower everyone to make the most of every moment.' }
  end
end
