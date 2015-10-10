import Foundation

public class ThemeBrowserCell : UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var highlightView: UIView!
    
    // MARK: - Properties
    
    public var theme : Theme? {
        didSet {
            refreshGUI()
        }
    }
    
    // MARK: - GUI
    
    /**
    @brief Calculates cell height fitting a given width
    
    @param width    Intended width
    @return         Matching height
    */
    public class func heightForWidth(width: CGFloat) -> CGFloat {
        
        let imageHeight = (width - WPStyleGuide.Themes.cellImageInset) * WPStyleGuide.Themes.cellImageRatio
        let height = imageHeight + WPStyleGuide.Themes.cellInfoBarHeight
        
        return height
    }
    
    override public var highlighted: Bool {
        didSet {
            let alphaFinal: CGFloat = highlighted ? 0.3 : 0
            UIView.animateWithDuration(0.2) { [weak self] in
                self?.highlightView.alpha = alphaFinal
            }
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.font = WPStyleGuide.Themes.cellNameFont
        infoLabel.font = WPStyleGuide.Themes.cellInfoFont
        
        layer.borderColor = WPStyleGuide.Themes.borderColor.CGColor
        layer.borderWidth = 1
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        theme = nil
    }
    
    private func refreshGUI() {
        if let theme = theme {
           if let imageUrl = theme.screenshotUrl where !imageUrl.isEmpty {
                self.refreshScreenshotImage(imageUrl)
            } else {
                imageView.image = nil
            }
            
            nameLabel.text = theme.name
            if theme.isCurrentTheme() {
                backgroundColor = WPStyleGuide.Themes.activeCellBackgroundColor
                nameLabel.textColor = WPStyleGuide.Themes.activeCellNameColor
                infoLabel.textColor = WPStyleGuide.Themes.activeCellInfoColor
                infoLabel.text = NSLocalizedString("ACTIVE", comment: "Label for active Theme browser cell")
            } else {
                backgroundColor = WPStyleGuide.Themes.inactiveCellBackgroundColor
                nameLabel.textColor = WPStyleGuide.Themes.inactiveCellNameColor
                if theme.isPremium() {
                    infoLabel.textColor = WPStyleGuide.Themes.inactiveCellPriceColor
                    infoLabel.text = theme.price
                } else {
                    infoLabel.text = nil
                }
            }
        } else {
            imageView.image = nil
            nameLabel.text = nil
            infoLabel.text = nil
        }
    }
    
    private func refreshScreenshotImage(imageUrl: String) {
        let imageUrl = NSURL(string: imageUrl)
        
        imageView.contentMode = .Center
        imageView.backgroundColor = WPStyleGuide.Themes.cellLoadingColor
        imageView.downloadImage(imageUrl,
            placeholderImage: UIImage(named: "theme-loading"),
            success: { [weak self] (image: UIImage) in
                self?.imageView.contentMode = .ScaleAspectFit
                self?.imageView.backgroundColor = UIColor.clearColor()
            }, failure: nil)
    }

    // MARK: - Actions
    
    @IBAction private func didTapActionButton(sender: UIButton) {
    }
    
}