// MARK: - Nav Actions
 
struct NavActionsView: View {
    let serverTime: String
 
    var body: some View {
        HStack(spacing: 12) {
            // Live dot
            HStack(spacing: 4) {
                Circle()
                    .fill(Color.accentGreen)
                    .frame(width: 6, height: 6)
                    .overlay(
                        Circle()
                            .stroke(Color.accentGreen.opacity(0.4), lineWidth: 3)
                            .scaleEffect(1.4)
                    )
                Text("LIVE")
                    .font(.system(size: 9, weight: .bold, design: .monospaced))
                    .foregroundStyle(Color.accentGreen)
            }
        }
    }
}