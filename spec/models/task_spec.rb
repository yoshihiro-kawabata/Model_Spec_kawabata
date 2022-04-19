require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "バリデーション" do
    it "タイトルが未入力の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: nil, description: "test", status: :todo, deadline: Time.current)
      #      バリデーションエラー検証
      #      task = Task.new(title: "test", description: "test", status: :todo, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Title can't be blank"]
      #      エラーメッセージ検証
      #      expect(task.errors.full_messages).to eq ["Title can be blank"]
    end

    it "ステータスが未入力の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: "test", description: "test", status: nil, deadline: Time.current)
      #      バリデーションエラー検証
      #      task = Task.new(title: "test", description: "test", status: :todo, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Status can't be blank"]
      #      エラーメッセージ検証
      #      expect(task.errors.full_messages).to eq ["Status can be blank"]
    end

    it "完了期限が未入力の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: nil)
      #      バリデーションエラー検証
      #      task = Task.new(title: "test", description: "test", status: :todo, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Deadline can't be blank"]
      #      エラーメッセージ検証
      #      expect(task.errors.full_messages).to eq ["Deadline can be blank"]
    end

    it "完了期限が過去の日付の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: Date.yesterday)
      #      バリデーションエラー検証
      #      task = Task.new(title: "test", description: "test", status: :todo, deadline: Date.today)
      expect(task).to be_invalid
      expect(task.deadline.strftime("%Y年 %m月 %d日")).to be < Date.today.strftime("%Y年 %m月 %d日")
    end

    it "完了期限が今日の日付の場合、タスクのバリデーションが有効であること" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: Date.today)
      #      バリデーションエラー検証
      #      task = Task.new(title: "test", description: "test", status: :todo, deadline: Date.yesterday)
      expect(task).to be_valid
      expect(task.deadline.strftime("%Y年 %m月 %d日")).to eq Date.today.strftime("%Y年 %m月 %d日")
    end
  end
end