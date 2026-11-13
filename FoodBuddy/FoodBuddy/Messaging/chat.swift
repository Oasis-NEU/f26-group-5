//  ChatView.swift
//  FoodBuddy – Messaging (starter)
//
//  A chat screen with tap-to-send quick replies instead of a keyboard.
//  Messages live in memory for now. Later, swap `send(_:)` for a
//  Supabase insert and load `messages` from the database.

import SwiftUI

// One chat message.
struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isMine: Bool
}

// The fixed list of things a person can say.
enum QuickReply: String, CaseIterable, Identifiable {
    case onMyWay   = "On my way! 🚶"
    case here      = "I’m here"
    case late      = "Running 5 min late"
    case where_    = "Where are you sitting?"
    case sounds    = "Sounds good 👍"
    case cantMake  = "Can’t make it, sorry"

    var id: String { rawValue }
}

struct ChatView: View {
    let hall: String
    let meetingSpot: String

    // Sample messages so the preview isn't empty.
    @State private var messages: [Message] = [
        Message(text: "Hey! See you at the meeting spot.", isMine: false)
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Plan card
            VStack(alignment: .leading, spacing: 2) {
                Text(hall).font(.headline)
                Text("Meeting spot: \(meetingSpot)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.secondarySystemBackground))

            // Message list
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(messages) { msg in
                            bubble(for: msg).id(msg.id)
                        }
                    }
                    .padding()
                }
                .onChange(of: messages.count) {
                    if let last = messages.last {
                        withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                    }
                }
            }

            // Quick replies (wraps onto two rows)
            FlowRow(spacing: 8) {
                ForEach(QuickReply.allCases) { reply in
                    Button(reply.rawValue) { send(reply) }
                        .buttonStyle(.bordered)
                        .tint(.red)
                }
            }
            .padding()
        }
    }

    private func bubble(for msg: Message) -> some View {
        HStack {
            if msg.isMine { Spacer(minLength: 40) }
            Text(msg.text)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(msg.isMine ? Color.red : Color(.secondarySystemBackground))
                .foregroundStyle(msg.isMine ? .white : .primary)
                .clipShape(RoundedRectangle(cornerRadius: 18))
            if !msg.isMine { Spacer(minLength: 40) }
        }
    }

    private func send(_ reply: QuickReply) {
        messages.append(Message(text: reply.rawValue, isMine: true))
    }
}

// Lays buttons out left to right and wraps to a new row when full.
struct FlowRow: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        var x: CGFloat = 0, y: CGFloat = 0, rowHeight: CGFloat = 0
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if x + size.width > maxWidth, x > 0 {
                x = 0; y += rowHeight + spacing; rowHeight = 0
            }
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
        return CGSize(width: maxWidth, height: y + rowHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX, y = bounds.minY, rowHeight: CGFloat = 0
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX, x > bounds.minX {
                x = bounds.minX; y += rowHeight + spacing; rowHeight = 0
            }
            view.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}

#Preview {
    ChatView(hall: "Stetson East", meetingSpot: "tables by the front windows")
}
